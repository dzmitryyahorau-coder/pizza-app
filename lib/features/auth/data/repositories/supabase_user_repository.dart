import 'package:pizza_app/features/auth/data/models/user.dart';
import 'package:pizza_app/features/auth/domain/repositories/user_repository_interface.dart';
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
}
