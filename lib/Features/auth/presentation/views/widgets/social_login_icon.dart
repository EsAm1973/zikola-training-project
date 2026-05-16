import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginIcon extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;

  const SocialLoginIcon({
    super.key,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(13.w),
          child: SvgPicture.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
