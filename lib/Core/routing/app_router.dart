import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola_training_project/Core/routing/app_routes.dart';
import 'package:zikola_training_project/Core/services/getit_service.dart';
import 'package:zikola_training_project/Features/auth/data/repos/auth_repo.dart';
import 'package:zikola_training_project/Features/auth/presentation/manager/login/login_cubit.dart';
import 'package:zikola_training_project/Features/auth/presentation/manager/register/register_cubit.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/forget_pass_view.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/login_view.dart';
import 'package:zikola_training_project/Features/auth/presentation/views/signup_view.dart';
import 'package:zikola_training_project/Features/onboarding/presentation/views/onboarding_view.dart';
import 'package:zikola_training_project/Features/splash/presentation/views/spalsh_view.dart';
import 'package:zikola_training_project/Features/home/presentation/views/home_view.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.kOnboardingView,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: AppRoutes.kLoginRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(getit<AuthRepo>()),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: AppRoutes.kSignupRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => RegisterCubit(authRepo: getit<AuthRepo>()),
          child: const SignupView(),
        ),
      ),
      GoRoute(
        path: AppRoutes.kForgetPasswordRoute,
        builder: (context, state) => const ForgetPassView(),
      ),
      GoRoute(
        path: AppRoutes.kHomeView,
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}
