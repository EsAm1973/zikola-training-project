import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola_training_project/generated/assets.dart';

import 'social_login_icon.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    String getAppleIconColor() {
      if (Theme.of(context).brightness == Brightness.dark) {
        return Assets.assetsIconsAppleIconLight;
      } else {
        return Assets.assetsIconsAppleIcon;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialLoginIcon(
          assetPath: Assets.assetsIconsGoogleIcon,
          onTap: () {
            // Handle Google login
          },
        ),
        SizedBox(width: 24.w),
        SocialLoginIcon(
          assetPath: getAppleIconColor(),
          onTap: () {
            // Handle Apple login
          },
        ),
        SizedBox(width: 24.w),
        SocialLoginIcon(
          assetPath: Assets.assetsIconsFacebookIcon,
          onTap: () {
            // Handle Facebook login
          },
        ),
      ],
    );
  }
}
