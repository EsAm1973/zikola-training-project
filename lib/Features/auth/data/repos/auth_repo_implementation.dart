import 'package:dartz/dartz.dart';
import 'package:zikola_training_project/Core/errors/failure.dart';
import 'package:zikola_training_project/Core/networking/api_consumer.dart';
import 'package:zikola_training_project/Core/networking/api_endpoints.dart';
import 'package:zikola_training_project/Features/auth/data/repos/auth_repo.dart';

class AuthRepoImplementation implements AuthRepo {
  final ApiConsumer apiConsumer;

  AuthRepoImplementation(this.apiConsumer);
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
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
