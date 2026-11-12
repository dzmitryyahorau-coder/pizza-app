import 'package:pizza_app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:pizza_app/features/auth/domain/repositories/user_repository_interface.dart';

class LogoutUseCase {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  const LogoutUseCase(this._authRepository, this._userRepository);

  Future<void> call() async {
    final userId = _authRepository.currentUserId;

    if (userId != null) {
      try {
        await _userRepository.updateFID(userId, null);
      } catch (e) {
        rethrow;
      }
    }

    await _authRepository.signOut();
  }
}
