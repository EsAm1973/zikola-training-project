import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola_training_project/Core/routing/app_routes.dart';
import 'package:zikola_training_project/Core/services/getit_service.dart';
import 'package:zikola_training_project/Core/services/secure_storage_service.dart';
import 'package:zikola_training_project/Core/services/shared_preferences_service.dart';
import 'package:zikola_training_project/Core/widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await getit<SecureStorageService>().clearTokens();
              await getit<SharedPreferencesService>().setLoggedIn(false);
              if (context.mounted) {
                GoRouter.of(context).go(AppRoutes.kLoginRoute);
              }
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Home!',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.h),
              CustomButton(
                text: 'Logout',
                onPressed: () async {
                  await getit<SecureStorageService>().clearTokens();
                  await getit<SharedPreferencesService>().setLoggedIn(false);
                  if (context.mounted) {
                    GoRouter.of(context).go(AppRoutes.kLoginRoute);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
