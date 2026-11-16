import 'package:pizza_app/core/domain/usecase.dart';
import 'package:pizza_app/features/profile/domain/repositories/auth_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/repositories/user_repository_interface.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';

class UpdateProfileParams {
  final String? newName;
  final String? newEmail;
  final String? newPassword;
  final String? currentPassword; // нужен для смены email и пароля

  const UpdateProfileParams({
    this.newName,
    this.newEmail,
    this.newPassword,
    this.currentPassword,
  });
}

class UpdateProfileUsecase extends Usecase<void, UpdateProfileParams> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final CurrentUserStore _currentUserStore;

  UpdateProfileUsecase({
    required this._authRepository,
    required this._userRepository,
    required this._currentUserStore,
  });

  @override
  Future<void> call(UpdateProfileParams params) async {
    final userId = _authRepository.currentUserId;
    if (userId == null) throw Exception('User is not authenticated');

    final needsReauth = params.newPassword != null || params.newEmail != null;
    if (needsReauth) {
      final current = params.currentPassword;
      if (current == null || current.isEmpty) {
        throw ArgumentError('currentPassword is required');
      }
      await _authRepository.reauthenticate(current);
    }

    if (params.newPassword != null) {
      await _authRepository.updatePassword(params.newPassword!);
    }

    if (params.newEmail != null) {
      await _authRepository.verifyBeforeUpdateEmail(params.newEmail!);
    }

    final name = params.newName;
    if (name != null) {
      await _userRepository.update(userId, name: name);
      _currentUserStore.update((u) => u.copyWith(name: name));
    }
  }
}
