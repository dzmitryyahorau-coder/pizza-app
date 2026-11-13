import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/profile/domain/usecases/update_avatar_usecase.dart';
import 'package:pizza_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:pizza_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:pizza_app/shared/auth/models/user.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UpdateAvatarUsecase _updateAvatarUsecase;
  final UpdateProfileUsecase _updateProfileUsecase;
  final CurrentUserStore _currentUserStore;

  StreamSubscription<User?>? _userSub;

  ProfileCubit({
    required this._updateAvatarUsecase,
    required this._updateProfileUsecase,
    required CurrentUserStore currentUserStore,
  }) : _currentUserStore = currentUserStore,
       super(ProfileState(user: currentUserStore.value)) {
    _userSub = _currentUserStore.stream.listen((user) {
      emit(user == null ? const ProfileState() : state.copyWith(user: user));
    });
  }

  Future<void> uploadAvatar(File imageFile) async {
    final user = state.user;
    if (user == null || state.isUpdating) return;

    emit(state.copyWith(isUpdating: true, clearMessages: true));

    try {
      await _updateAvatarUsecase(
        UpdateAvatarParams(userId: user.id, file: imageFile),
      );

      if (isClosed) return;
      emit(state.copyWith(isUpdating: false));
    } catch (_) {
      if (isClosed) return;
      emit(state.copyWith(isUpdating: false, errorKey: 'errorUnknown'));
    }
  }

  Future<void> updateProfileSettings({
    String? name,
    String? email,
    String? currentPassword,
  }) async {
    final user = state.user;
    if (user == null || state.isUpdating) return;

    emit(state.copyWith(isUpdating: true, clearMessages: true));

    try {
      await _updateProfileUsecase(
        UpdateProfileParams(
          newName: name,
          newEmail: email,
          currentPassword: currentPassword,
        ),
      );

      if (isClosed) return;
      emit(
        state.copyWith(
          isUpdating: false,
          successKey: email != null ? 'emailVerificationSent' : 'profileSaved',
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (isClosed) return;
      final key = switch (e.code) {
        'invalid-credential' => 'errorInvalidCredentials',
        'email-already-in-use' => 'errorEmailInUse',
        'invalid-email' => 'errorInvalidEmail',
        'too-many-requests' => 'errorTooManyRequests',
        _ => 'errorUnknown',
      };
      emit(state.copyWith(isUpdating: false, errorKey: key));
    } catch (_) {
      if (isClosed) return;
      emit(state.copyWith(isUpdating: false, errorKey: 'errorUnknown'));
    }
  }

  @override
  Future<void> close() {
    _userSub?.cancel();
    return super.close();
  }
}
