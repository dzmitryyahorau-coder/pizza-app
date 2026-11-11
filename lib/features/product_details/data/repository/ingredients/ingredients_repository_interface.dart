import 'package:pizza_app/features/product_details/data/models/ingredient.dart';

abstract interface class IIngredientsRepository {
  Future<List<Ingredient>> getIngredients();
}
