import 'package:pizza_app/shared/auth/models/user.dart';
import 'package:pizza_app/features/profile/domain/repositories/user_repository_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

const tableName = 'user';

class SupabaseUserRepository implements IUserRepository {
  final SupabaseClient _supabase;

  const SupabaseUserRepository(this._supabase);

  @override
  Future<void> create(User user) async {
    try {
      final userData = user.toMap();

      await _supabase.from(tableName).insert(userData);
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        throw Exception('User already exists');
      }
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  @override
  Future<void> updateFID(String userId, String? token) async {
    try {
      await _supabase
          .from(tableName)
          .update({'fid_token': token})
          .eq('id', userId);
    } on PostgrestException catch (e) {
      throw Exception('Failed to update FID token: ${e.message}');
    }
  }

  @override
  Future<void> update(
    String userId, {
    String? name,
    String? email,
    String? avatar,
  }) async {
    final data = <String, dynamic>{
      'name': ?name,
      'email': ?email,
      'avatar_src': ?avatar,
    };

    if (data.isEmpty) return;

    try {
      final updated = await _supabase
          .from(tableName)
          .update(data)
          .eq('id', userId)
          .select();

      if (updated.isEmpty) {
        throw Exception('User was not updated: no row matched');
      }
    } on PostgrestException catch (e) {
      throw Exception('Failed to update user: ${e.message}');
    }
  }

  @override
  Future<User?> getById(String userId) async {
    try {
      final data = await _supabase
          .from(tableName)
          .select()
          .eq('id', userId)
          .maybeSingle();

      return data == null ? null : User.fromMap(data);
    } on PostgrestException catch (e) {
      throw Exception('Failed to get user: ${e.message}');
    }
  }
}
