import 'package:pizza_app/features/product_details/data/models/ingredient.dart';
import 'package:pizza_app/features/product_details/data/repository/ingredients/ingredients_repository_interface.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const tableName = 'ingredient';

class SupabaseIngredientsRepository implements IIngredientsRepository {
  @override
  Future<List<Ingredient>> getIngredients() async {
    final data = await Supabase.instance.client.from(tableName).select();

    final result = data.map((row) => Ingredient.fromMap(row)).toList();

    return result;
  }
}
