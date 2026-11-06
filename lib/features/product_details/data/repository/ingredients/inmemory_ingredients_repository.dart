import 'package:pizza_app/features/product_details/data/models/ingredient.dart';
import 'package:pizza_app/features/product_details/data/repository/ingredients/ingredients_repository_interface.dart';

class InmemoryIngredientsRepository implements IIngredientsRepository {
  final List<Ingredient> _store;

  InmemoryIngredientsRepository({List<Ingredient>? store})
    : _store = store ?? [];

  @override
  Future<List<Ingredient>> getIngredients() {
    return Future.syncValue(_store);
  }
}
