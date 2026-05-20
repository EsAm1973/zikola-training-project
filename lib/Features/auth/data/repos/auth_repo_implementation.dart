import 'package:dartz/dartz.dart';
import 'package:zikola_training_project/Core/errors/failure.dart';
import 'package:zikola_training_project/Core/networking/api_consumer.dart';
import 'package:zikola_training_project/Core/networking/api_endpoints.dart';
import 'package:zikola_training_project/Core/services/secure_storage_service.dart';
import 'package:zikola_training_project/Core/services/shared_preferences_service.dart';
import 'package:zikola_training_project/Features/auth/data/repos/auth_repo.dart';

class AuthRepoImplementation implements AuthRepo {
  final ApiConsumer apiConsumer;
  final SecureStorageService secureStorageService;
  final SharedPreferencesService sharedPreferencesService;

  AuthRepoImplementation(
    this.apiConsumer,
    this.secureStorageService,
    this.sharedPreferencesService,
  );

  @override
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String name,
    required String email,
    required String password,
    required String avatarURL,
  }) async {
    try {
      final response = await apiConsumer.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'avatar': avatarURL,
        },
      );
      return Right(response);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiConsumer.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      final accessToken = response['access_token'] as String?;
      final refreshToken = response['refresh_token'] as String?;

      if (accessToken != null && refreshToken != null) {
        await secureStorageService.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
        await sharedPreferencesService.setLoggedIn(true);
        return Right(response);
      } else {
        return Left(
          ServerFailure(errorMessage: 'Invalid tokens received from server.'),
        );
      }
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
