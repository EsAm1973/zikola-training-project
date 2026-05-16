import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola_training_project/Core/widgets/custom_text_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String get name => _nameController.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _nameController,
            hintText: 'Full Name',
            prefixIcon: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              size: 24.sp,
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: _validateName,
          ),
          SizedBox(height: 30.h),
          CustomTextField(
            controller: _emailController,
            hintText: 'Email',
            prefixIcon: Icon(
              Icons.email,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              size: 24.sp,
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validateEmail,
          ),
          SizedBox(height: 30.h),
          CustomTextField(
            controller: _passwordController,
            hintText: 'Password',
            obscureText: _obscurePassword,
            prefixIcon: Icon(
              Icons.lock,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              size: 24.sp,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                size: 20.sp,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            textInputAction: TextInputAction.next,
            validator: _validatePassword,
          ),
          SizedBox(height: 30.h),
          CustomTextField(
            controller: _confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: _obscureConfirmPassword,
            prefixIcon: Icon(
              Icons.lock,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              size: 24.sp,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                size: 20.sp,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            textInputAction: TextInputAction.done,
            validator: _validateConfirmPassword,
            onSubmitted: (_) => {},
          ),
        ],
      ),
    );
  }
}
