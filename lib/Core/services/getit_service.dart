import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zikola_training_project/Core/networking/dio_consumer.dart';
import 'package:zikola_training_project/Core/services/secure_storage_service.dart';
import 'package:zikola_training_project/Core/services/shared_preferences_service.dart';
import 'package:zikola_training_project/Features/auth/data/repos/auth_repo.dart';
import 'package:zikola_training_project/Features/auth/data/repos/auth_repo_implementation.dart';

final getit = GetIt.instance;

Future<void> setupGetIt() async {
  // Register SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getit.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService(prefs));

  // Register SecureStorageService
  getit.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService());

  // Register DioConsumer as a singleton
  getit.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: Dio()));

  // Register AuthRepoImplementation as a singleton, injecting DioConsumer
  getit.registerLazySingleton<AuthRepo>(
    () => AuthRepoImplementation(getit<DioConsumer>()),
  );
}
