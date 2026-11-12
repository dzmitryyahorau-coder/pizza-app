import 'package:pizza_app/features/auth/data/models/user.dart';

abstract interface class IUserRepository {
  Future<void> create(User user);
  Future<void> updateFID(String userId, String? fid);
}
