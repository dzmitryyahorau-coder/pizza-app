import 'package:pizza_app/core/domain/usecase.dart';
import 'package:pizza_app/features/auth/data/models/user.dart';
import 'package:pizza_app/features/auth/domain/repositories/auth_repository_interface.dart';

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}

class SignInUsecase extends Usecase<User, SignInParams> {
  final IAuthRepository _authRepository;

  SignInUsecase(this._authRepository);

  @override
  Future<User> call(SignInParams params) async {
    final user = await _authRepository.signIn(
      email: params.email,
      password: params.password,
    );

    return user;
  }
}
