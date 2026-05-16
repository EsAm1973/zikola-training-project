import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zikola_training_project/Features/auth/data/repos/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;
  RegisterCubit({required this.authRepo}) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String avatarURL,
  }) async {
    emit(RegisterLoading());
    final result = await authRepo.register(
      name: name,
      email: email,
      password: password,
      avatarURL: avatarURL,
    );
    result.fold(
      (failure) => emit(RegisterError(errorMessage: failure.errorMessage)),
      (responseData) => emit(RegisterSuccess(responseData: responseData)),
    );
  }
}
