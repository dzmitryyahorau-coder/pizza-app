import 'package:pizza_app/features/order/data/models/order.dart';
import 'package:pizza_app/features/order/domain/repositories/order_repository_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseOrderRepository implements IOrderRepository {
  final SupabaseClient _supabase;

  SupabaseOrderRepository(this._supabase);

  @override
  Future<void> create(Order order) async {
    await _supabase.rpc(
      'create_order',
      params: {
        'p_order': order.toMap(),
        'p_items': order.items.map((i) => i.toMap()).toList(),
      },
    );
  }
}
