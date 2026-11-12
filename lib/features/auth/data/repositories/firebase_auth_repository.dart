import 'package:pizza_app/features/auth/data/models/user.dart';
import 'package:pizza_app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;

  const FirebaseAuthRepository(this._firebaseAuth);

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return User(id: credential.user!.uid, name: name, email: email);
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final fbUser = credential.user;
      if (fbUser == null) {
        throw Exception('User is null after sign in');
      }

      return User(
        id: fbUser.uid,
        name: fbUser.displayName ?? '',
        email: fbUser.email ?? email.trim(),
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}
