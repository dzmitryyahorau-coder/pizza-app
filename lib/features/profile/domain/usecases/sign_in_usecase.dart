import 'package:pizza_app/core/domain/usecase.dart';
import 'package:pizza_app/features/profile/domain/repositories/user_repository_interface.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:pizza_app/shared/auth/models/user.dart';
import 'package:pizza_app/features/profile/domain/repositories/auth_repository_interface.dart';

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}

class SignInUsecase extends Usecase<User, SignInParams> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final CurrentUserStore _currentUserStore;

  SignInUsecase(
    this._authRepository,
    this._userRepository,
    this._currentUserStore,
  );

  @override
  Future<User> call(SignInParams params) async {
    final fbUser = await _authRepository.signIn(
      email: params.email,
      password: params.password,
    );

    User? profile;
    try {
      profile = await _userRepository.getById(fbUser.id);
    } catch (_) {}

    final user = profile ?? fbUser;
    _currentUserStore.set(user);
    return user;
  }
}
