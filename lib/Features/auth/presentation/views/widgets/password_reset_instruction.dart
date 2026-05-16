import 'package:flutter/material.dart';
import 'package:zikola_training_project/Core/utils/app_text_styles.dart';

class PasswordResetInstruction extends StatelessWidget {
  const PasswordResetInstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: AppTextStyles.regular12.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .6),
        ),
        children: [
          TextSpan(
            text: '* ',
            style: AppTextStyles.regular14.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const TextSpan(
            text:
                'We will send you a message to set or reset your new password',
          ),
        ],
      ),
    );
  }
}
