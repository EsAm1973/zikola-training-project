import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikola_training_project/Core/services/getit_service.dart';
import 'package:zikola_training_project/Core/services/secure_storage_service.dart';
import 'package:zikola_training_project/Core/services/shared_preferences_service.dart';
import 'package:zikola_training_project/Features/auth/data/repos/auth_repo.dart';
import 'package:zikola_training_project/Features/auth/presentation/manager/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    final result = await authRepo.login(email: email, password: password);

    result.fold(
      (failure) {
        emit(LoginFailure(errorMessage: failure.errorMessage));
      },
      (success) async {
        final secureStorage = getit<SecureStorageService>();
        final sharedPrefs = getit<SharedPreferencesService>();

        final accessToken = success['access_token'];
        final refreshToken = success['refresh_token'];

        if (accessToken != null && refreshToken != null) {
          await secureStorage.saveTokens(
            accessToken: accessToken,
            refreshToken: refreshToken,
          );
          await sharedPrefs.setLoggedIn(true);
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(errorMessage: 'Invalid tokens received from server.'));
        }
      },
    );
  }
}
