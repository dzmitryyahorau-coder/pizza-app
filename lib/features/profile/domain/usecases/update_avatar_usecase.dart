import 'dart:io';

import 'package:pizza_app/core/domain/usecase.dart';
import 'package:pizza_app/features/profile/domain/repositories/storage_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/repositories/user_repository_interface.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';

class UpdateAvatarParams {
  final String userId;
  final File file;

  const UpdateAvatarParams({required this.userId, required this.file});
}

class UpdateAvatarUsecase extends Usecase<String, UpdateAvatarParams> {
  final IStorageRepository _storageRepository;
  final IUserRepository _userRepository;
  final CurrentUserStore _currentUserStore;

  UpdateAvatarUsecase(
    this._storageRepository,
    this._userRepository,
    this._currentUserStore,
  );

  @override
  Future<String> call(UpdateAvatarParams params) async {
    final publicUrl = await _storageRepository.uploadAvatar(
      params.userId,
      params.file,
    );
    await _userRepository.update(params.userId, avatar: publicUrl);

    _currentUserStore.update((u) => u.copyWith(avatarSrc: publicUrl));

    return publicUrl;
  }
}
