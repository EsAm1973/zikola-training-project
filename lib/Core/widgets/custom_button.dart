import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola_training_project/Core/utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool isExpanded;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidth = isExpanded ? double.infinity : width;
    final buttonHeight = height ?? 56.h;
    final bgColor = backgroundColor ?? Theme.of(context).colorScheme.primary;
    final txtColor = textColor ?? Theme.of(context).colorScheme.onPrimary;

    Widget buttonContent = isLoading
        ? SizedBox(
            height: 24.h,
            width: 24.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(txtColor),
            ),
          )
        : Text(text, style: AppTextStyles.semiBold20.copyWith(color: txtColor));

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
        ),
        child: buttonContent,
      ),
    );
  }
}
