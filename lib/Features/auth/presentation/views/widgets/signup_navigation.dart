import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola_training_project/Core/routing/app_routes.dart';
import 'package:zikola_training_project/Core/utils/app_text_styles.dart';

class SignupNavigation extends StatelessWidget {
  const SignupNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Create An Account',
            style: AppTextStyles.regular14.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          SizedBox(width: 4.w),
          TextButton(
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRoutes.kSignupRoute);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Sign Up',
              style: AppTextStyles.bold14.copyWith(
                color: const Color(0xFFF73658),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
