import 'package:pizza_app/features/menu/data/models/category.dart';
import 'package:pizza_app/features/menu/data/repositories/categories/categories_repository_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const tableName = 'product_category';

class SupabaseCategoriesRepository implements ICategoriesRepository {
  @override
  Future<List<Category>> getCategories() async {
    final data = await Supabase.instance.client.from(tableName).select();

    final result = data.map((row) => Category.fromMap(row)).toList();

    return result;
  }
}
