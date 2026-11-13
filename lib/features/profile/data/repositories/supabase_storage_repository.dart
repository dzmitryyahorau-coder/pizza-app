import 'dart:io';

import 'package:pizza_app/features/profile/domain/repositories/storage_repository_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const bucketName = 'profiles';

class SupabaseStorageRepository implements IStorageRepository {
  final SupabaseClient _supabase;

  SupabaseStorageRepository(this._supabase);

  @override
  Future<String> uploadAvatar(String userId, File file) async {
    final fileExt = file.path.split('.').last;
    final fileName =
        '$userId-${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final filePath = '$userId/$fileName';

    await _supabase.storage.from(bucketName).upload(filePath, file);

    return _supabase.storage.from(bucketName).getPublicUrl(filePath);
  }
}
