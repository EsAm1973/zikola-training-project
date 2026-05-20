import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola_training_project/Core/networking/api_interceptors.dart';
import 'package:zikola_training_project/Core/routing/app_routes.dart';
import 'package:zikola_training_project/Core/routing/app_router.dart';
import 'package:zikola_training_project/Core/services/getit_service.dart';
import 'package:zikola_training_project/Core/utils/app_theme.dart';
import 'package:zikola_training_project/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  runApp(const ZikolaTrainingProject());
}

class ZikolaTrainingProject extends StatefulWidget {
  const ZikolaTrainingProject({super.key});

  @override
  State<ZikolaTrainingProject> createState() => _ZikolaTrainingProjectState();
}

class _ZikolaTrainingProjectState extends State<ZikolaTrainingProject> {
  late StreamSubscription<AuthEvent> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = AuthEventBus.instance.stream.listen((event) {
      if (event == AuthEvent.logout) {
        AppRouter.router.go(AppRoutes.kLoginRoute);
      }
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        locale: const Locale('en'),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: AppTheme.getLightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
