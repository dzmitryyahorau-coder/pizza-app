import 'package:pizza_app/features/profile/domain/repositories/auth_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/repositories/user_repository_interface.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';

class LogoutUseCase {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final CurrentUserStore _currentUserStore;

  const LogoutUseCase(
    this._authRepository,
    this._userRepository,
    this._currentUserStore,
  );

  Future<void> call() async {
    final userId = _authRepository.currentUserId;

    if (userId != null) {
      try {
        await _userRepository.updateFID(userId, null);
      } catch (_) {}
    }
    await _authRepository.signOut();
    _currentUserStore.set(null);
  }
}
