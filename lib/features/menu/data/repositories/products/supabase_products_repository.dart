import 'package:pizza_app/features/menu/data/models/product.dart';
import 'package:pizza_app/features/menu/domain/repositories/products/products_repository_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const tableName = 'product';

class SupabaseProductsRepository implements IProductsRepository {
  @override
  Future<List<Product>> getProducts() async {
    try {
      final data = await Supabase.instance.client.from(tableName).select();

      final result = data.map((row) => Product.fromMap(row)).toList();

      return result;
    } on PostgrestException catch (e) {
      throw e.message;
    }
  }
}
