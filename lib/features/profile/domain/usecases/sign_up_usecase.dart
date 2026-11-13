import 'package:pizza_app/core/domain/usecase.dart';
import 'package:pizza_app/features/profile/domain/repositories/auth_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/repositories/user_repository_interface.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:pizza_app/shared/auth/models/user.dart';

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
  final CurrentUserStore _currentUserStore;

  SignUpUsecase(
    this._authRepository,
    this._userRepository,
    this._currentUserStore,
  );

  @override
  Future<User> call(SignUpParams params) async {
    final user = await _authRepository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );

    await _userRepository.create(user);

    _currentUserStore.set(user);

    return user;
  }
}
