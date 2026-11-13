import 'dart:io';

abstract interface class IStorageRepository {
  Future<String> uploadAvatar(String userId, File file);
}
