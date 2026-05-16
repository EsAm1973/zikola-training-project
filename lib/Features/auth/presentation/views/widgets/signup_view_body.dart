import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola_training_project/Core/widgets/custom_button.dart';
import 'package:zikola_training_project/Features/auth/presentation/manager/register/register_cubit.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/auth_dialog.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/login_navigation.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/or_continue_with_divider.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/signup_form.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/signup_title.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/social_login_buttons.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/terms_text.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<SignupFormState>();

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AuthDialog(
              isSuccess: true,
              message: 'Registration successful! Please login to continue.',
            ),
          );
        } else if (state is RegisterError) {
          showDialog(
            context: context,
            builder: (context) =>
                AuthDialog(isSuccess: false, message: state.errorMessage),
          );
        }
      },

      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SignupTitle(),
            SignupForm(key: formKey),
            SizedBox(height: 9.h),
            const TermsText(),
            SizedBox(height: 38.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CustomButton(
                  text: 'Create Account',
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form != null && form.formKey.currentState!.validate()) {
                      context.read<RegisterCubit>().register(
                        name: form.name,
                        email: form.email,
                        password: form.password,
                        avatarURL:
                            "https://api.dicebear.com/6.x/avataaars/svg?seed=Felix",
                      );
                    }
                  },
                );
              },
            ),
            SizedBox(height: 40.h),
            const OrContinueWithDivider(),
            SizedBox(height: 20.h),
            const SocialLoginButtons(),
            SizedBox(height: 28.h),
            const LoginNavigation(),
          ],
        ),
      ),
    );
  }
}
