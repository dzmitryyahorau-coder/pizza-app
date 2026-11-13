import 'package:pizza_app/shared/auth/models/user.dart';
import 'package:pizza_app/features/profile/domain/repositories/auth_repository_interface.dart';
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

      await credential.user?.getIdToken(true);

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

  @override
  Future<void> reauthenticate(String password) async {
    final user = _firebaseAuth.currentUser!;
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);
  }

  @override
  Future<void> updatePassword(String newPassword) =>
      _firebaseAuth.currentUser!.updatePassword(newPassword);

  @override
  Future<void> verifyBeforeUpdateEmail(String newEmail) =>
      _firebaseAuth.currentUser!.verifyBeforeUpdateEmail(newEmail);
}
