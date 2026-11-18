import 'package:pizza_app/features/delivery/data/models/address.dart';
import 'package:pizza_app/features/delivery/data/repositories/address_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const tableName = 'address';

class SupabaseAddressRepository implements IAddressRepository {
  final SupabaseClient _supabase;

  SupabaseAddressRepository(this._supabase);

  @override
  Future<Address> addAddress(String userId, Address address) async {
    final data = address.toMap()
      ..remove('id')
      ..['user_id'] = userId;

    final row = await _supabase.from(tableName).insert(data).select().single();
    return Address.fromMap(row);
  }

  @override
  Future<Address> getAddressById(String id) async {
    final row = await _supabase.from(tableName).select().eq('id', id).single();
    return Address.fromMap(row);
  }

  @override
  Future<List<Address>> getUserAddresses(String userId) async {
    final rows = await _supabase
        .from(tableName)
        .select()
        .eq('user_id', userId)
        .order('created_at');
    return rows.map(Address.fromMap).toList();
  }
}
