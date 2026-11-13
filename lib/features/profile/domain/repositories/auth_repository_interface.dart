import 'package:pizza_app/shared/auth/models/user.dart';

abstract interface class IAuthRepository {
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<User> signIn({required String email, required String password});

  Future<void> signOut();

  Future<void> reauthenticate(String password);
  Future<void> updatePassword(String newPassword);
  Future<void> verifyBeforeUpdateEmail(String newEmail);

  String? get currentUserId;
}
