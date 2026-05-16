import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zikola_training_project/Core/networking/dio_consumer.dart';
import 'package:zikola_training_project/Features/auth/data/repos/auth_repo.dart';
import 'package:zikola_training_project/Features/auth/data/repos/auth_repo_implementation.dart';

final getit = GetIt.instance;

void setupGetIt() {
  // Register DioConsumer as a singleton
  getit.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: Dio()));

  // Register AuthRepoImplementation as a singleton, injecting DioConsumer
  getit.registerLazySingleton<AuthRepo>(
    () => AuthRepoImplementation(getit<DioConsumer>()),
  );
}
