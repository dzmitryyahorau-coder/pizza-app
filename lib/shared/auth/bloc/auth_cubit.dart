import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/shared/auth/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial()) {
    checkAuth();
  }

  Future<void> checkAuth() async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(seconds: 15));

    emit(const Unauthenticated());
  }

  Future<void> login({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      emit(const AuthError(messageKey: 'errorEmptyFields'));
      return;
    }

    emit(const AuthLoading());
    await Future.delayed(const Duration(milliseconds: 800));

    if (email.contains('@') && password.length >= 6) {
      emit(Authenticated(email: email));
    } else {
      emit(const AuthError(messageKey: 'errorInvalidCredentials'));
      emit(const Unauthenticated());
    }
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(const Unauthenticated());
  }
}
