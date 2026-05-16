import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola_training_project/Core/utils/app_text_styles.dart';

class OnboardingTopBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onSkip;

  const OnboardingTopBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${currentPage + 1}',
                  style: AppTextStyles.bold18.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                TextSpan(
                  text: '/$totalPages',
                  style: AppTextStyles.bold18.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onSkip,
            child: Text(
              'Skip',
              style: AppTextStyles.bold18.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
