import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/profile/domain/usecases/logout_usecase.dart';
import 'package:pizza_app/features/profile/domain/usecases/sign_in_usecase.dart';
import 'package:pizza_app/features/profile/domain/usecases/sign_up_usecase.dart';
import 'package:pizza_app/shared/auth/bloc/auth_state.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:pizza_app/shared/auth/models/user.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUsecase _signUpUsecase;
  final SignInUsecase _signInUsecase;
  final LogoutUseCase _logoutUseCase;
  final CurrentUserStore _currentUserStore;

  StreamSubscription<User?>? _userSub;

  AuthCubit({
    required this._signUpUsecase,
    required this._signInUsecase,
    required this._logoutUseCase,
    required this._currentUserStore,
  }) : super(const AuthInitial()) {
    _userSub = _currentUserStore.stream.listen((user) {
      emit(user != null ? Authenticated(user: user) : const Unauthenticated());
    });
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || name.isEmpty || password.isEmpty) {
      emit(const AuthError(messageKey: 'errorEmptyFields'));
      return;
    }

    emit(const AuthLoading());

    try {
      await _signUpUsecase(
        SignUpParams(email: email, password: password, name: name),
      );
    } catch (e) {
      emit(const AuthError(messageKey: 'errorUnknown'));
    }
  }

  Future<void> login({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      emit(const AuthError(messageKey: 'errorEmptyFields'));
      return;
    }

    emit(const AuthLoading());

    try {
      await _signInUsecase(SignInParams(email: email, password: password));
    } on FirebaseAuthException catch (e) {
      final messageKey = switch (e.code) {
        'user-not-found' => 'errorUserNotFound',
        'invalid-credential' => 'errorInvalidCredentials',
        'too-many-requests' => 'errorTooManyRequests',
        _ => 'errorUnknown',
      };
      emit(AuthError(messageKey: messageKey));
    } catch (e) {
      emit(const AuthError(messageKey: 'errorUnknown'));
    }
  }

  Future<void> logout() async {
    emit(const AuthLoading());

    try {
      await _logoutUseCase();
    } catch (e) {
      final user = _currentUserStore.value;
      emit(user != null ? Authenticated(user: user) : const Unauthenticated());
    }
  }

  @override
  Future<void> close() {
    _userSub?.cancel();
    return super.close();
  }
}
