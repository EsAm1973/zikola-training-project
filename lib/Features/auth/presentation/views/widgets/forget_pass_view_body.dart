import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola_training_project/Core/widgets/custom_button.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/forgot_password_form.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/forgot_password_title.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/password_reset_instruction.dart';

class ForgetPassViewBody extends StatelessWidget {
  const ForgetPassViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ForgotPasswordTitle(),
          SizedBox(height: 10.h),
          const ForgotPasswordForm(),
          SizedBox(height: 26.h),
          const PasswordResetInstruction(),
          SizedBox(height: 35.h),
          CustomButton(text: 'Submit', onPressed: () {}),
        ],
      ),
    );
  }
}
