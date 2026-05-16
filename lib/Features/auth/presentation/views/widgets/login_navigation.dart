import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola_training_project/Core/routing/app_routes.dart';
import 'package:zikola_training_project/Core/utils/app_text_styles.dart';

class LoginNavigation extends StatelessWidget {
  const LoginNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'I Already Have an Account',
            style: AppTextStyles.regular14.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          SizedBox(width: 4.w),
          TextButton(
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRoutes.kLoginRoute);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Login',
              style: AppTextStyles.bold14.copyWith(
                color: Theme.of(context).colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
