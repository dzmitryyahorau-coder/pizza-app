import 'package:pizza_app/shared/auth/models/user.dart';

abstract interface class IUserRepository {
  Future<void> create(User user);
  Future<void> updateFID(String userId, String? fid);

  Future<User?> getById(String userId);

  Future<void> update(
    String userId, {
    String? name,
    String? email,
    String? avatar,
  });
}
