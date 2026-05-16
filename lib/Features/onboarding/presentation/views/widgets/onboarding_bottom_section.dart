import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola_training_project/Core/utils/app_colors.dart';
import 'package:zikola_training_project/Core/utils/app_text_styles.dart';

class OnboardingBottomSection extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;

  const OnboardingBottomSection({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        children: [
          // Dots indicator
          DotsIndicator(
            dotsCount: totalPages,
            position: currentPage.toDouble(),
            animate: true,
            decorator: DotsDecorator(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.3),
              activeColor: Theme.of(context).colorScheme.onSurface,
              shape: const CircleBorder(),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              size: Size(8.w, 8.h),
              activeSize: Size(40.w, 8.h),
              spacing: EdgeInsets.symmetric(horizontal: 4.w),
            ),
          ),
          SizedBox(height: 24.h),

          // Next button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onNext,
              child: currentPage < totalPages - 1
                  ? Text(
                      'Next',
                      style: AppTextStyles.bold18.copyWith(
                        color: AppColors.primary,
                      ),
                    )
                  : Text(
                      'Get Started',
                      style: AppTextStyles.bold18.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
