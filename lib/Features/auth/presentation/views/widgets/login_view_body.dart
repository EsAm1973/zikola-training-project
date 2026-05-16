import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola_training_project/Core/widgets/custom_button.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/login_form.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/or_continue_with_divider.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/signup_navigation.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/social_login_buttons.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/welcome_text.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<LoginFormState>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WelcomeText(),
          LoginForm(key: formKey),
          SizedBox(height: 52.h),
          CustomButton(text: 'Login', onPressed: () {}),
          SizedBox(height: 75.h),
          const OrContinueWithDivider(),
          SizedBox(height: 20.h),
          const SocialLoginButtons(),
          SizedBox(height: 28.h),
          const SignupNavigation(),
        ],
      ),
    );
  }
}
