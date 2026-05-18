import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikola_training_project/Core/services/getit_service.dart';
import 'package:zikola_training_project/Features/auth/data/repos/auth_repo.dart';
import 'package:zikola_training_project/Features/auth/presentation/manager/login/login_cubit.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginCubit(getit<AuthRepo>()),
          child: const LoginViewBody(),
        ),
      ),
    );
  }
}