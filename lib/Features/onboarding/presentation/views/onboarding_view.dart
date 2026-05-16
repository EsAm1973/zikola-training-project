import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola_training_project/Core/routing/app_routes.dart';
import 'package:zikola_training_project/Features/onboarding/data/constants/onboarding_data.dart';
import 'package:zikola_training_project/Features/onboarding/presentation/views/widgets/onboarding_bottom_section.dart';
import 'package:zikola_training_project/Features/onboarding/presentation/views/widgets/onboarding_page_content.dart';
import 'package:zikola_training_project/Features/onboarding/presentation/views/widgets/onboarding_top_bar.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < OnboardingData.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Prefs.setBool(isOnboadingViewSeenKey, true);
      GoRouter.of(context).pushReplacement(AppRoutes.kLoginRoute);
    }
  }

  void _skipOnboarding() {
    _pageController.jumpToPage(OnboardingData.pages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with page indicator and Skip button
            OnboardingTopBar(
              currentPage: _currentPage,
              totalPages: OnboardingData.pages.length,
              onSkip: _skipOnboarding,
            ),

            // PageView with onboarding pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: OnboardingData.pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPageContent(
                    pageData: OnboardingData.pages[index],
                  );
                },
              ),
            ),

            // Bottom section with dots indicator and Next button
            OnboardingBottomSection(
              currentPage: _currentPage,
              totalPages: OnboardingData.pages.length,
              onNext: _nextPage,
            ),
          ],
        ),
      ),
    );
  }
}
