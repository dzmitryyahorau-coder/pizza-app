import 'package:pizza_app/features/auth/data/models/user.dart';

abstract interface class IAuthRepository {
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<User> signIn({required String email, required String password});

  Future<void> signOut();

  String? get currentUserId;
}
