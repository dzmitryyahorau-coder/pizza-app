import 'package:pizza_app/core/domain/usecase.dart';
import 'package:pizza_app/features/auth/data/models/user.dart';
import 'package:pizza_app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:pizza_app/features/auth/domain/repositories/user_repository_interface.dart';

class SignUpParams {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String name;
}

class SignUpUsecase extends Usecase<User, SignUpParams> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  SignUpUsecase(this._authRepository, this._userRepository);

  @override
  Future<User> call(SignUpParams params) async {
    final user = await _authRepository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );

    await _userRepository.create(user);

    return user;
  }
}
