import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/auth/data/models/user.dart';
import 'package:pizza_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:pizza_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:pizza_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:pizza_app/shared/auth/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUsecase _signUpUsecase;
  final SignInUsecase _signInUsecase;
  final LogoutUseCase _logoutUseCase;

  AuthCubit({
    required this._signUpUsecase,
    required this._signInUsecase,
    required this._logoutUseCase,
  }) : super(const AuthInitial()) {
    checkAuth();
  }

  void checkAuth() {
    emit(const AuthLoading());

    final fbUser = FirebaseAuth.instance.currentUser;

    if (fbUser != null) {
      emit(
        Authenticated(
          user: User(
            id: fbUser.uid,
            name: fbUser.displayName ?? '',
            email: fbUser.email ?? '',
          ),
        ),
      );
    } else {
      emit(const Unauthenticated());
    }
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

    emit(AuthLoading());

    try {
      final user = await _signUpUsecase(
        SignUpParams(email: email, password: password, name: name),
      );

      emit(Authenticated(user: user));
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
      final user = await _signInUsecase(
        SignInParams(email: email, password: password),
      );
      emit(Authenticated(user: user));
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
      emit(const Unauthenticated());
    } catch (e) {
      emit(const Unauthenticated());
    }
  }
}
