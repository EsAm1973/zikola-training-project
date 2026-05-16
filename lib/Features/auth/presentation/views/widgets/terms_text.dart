import 'package:flutter/material.dart';
import 'package:zikola_training_project/Core/utils/app_text_styles.dart';

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: AppTextStyles.regular14.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .6),
        ),
        children: [
          const TextSpan(text: 'By clicking the '),
          TextSpan(
            text: 'Register',
            style: AppTextStyles.regular14.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const TextSpan(text: ' button, you agree to the public offer'),
        ],
      ),
    );
  }
}
