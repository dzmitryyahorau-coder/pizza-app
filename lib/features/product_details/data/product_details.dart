import 'package:pizza_app/features/product_details/data/dough.dart';
import 'package:pizza_app/features/product_details/data/ingredient.dart';
import 'package:pizza_app/features/product_details/data/topping.dart';
import 'package:pizza_app/features/product_details/data/product_size.dart';

class ProductDetails {
  const ProductDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.imageAsset,
    required this.sizes,
    required this.defaultSizeId,
    required this.doughs,
    required this.toppings,
    required this.ingredients,
  });

  final String id;
  final String name;
  final String description;
  final String imageAsset;
  final List<ProductSize> sizes;
  final String defaultSizeId;
  final List<Dough> doughs;
  final List<Topping> toppings;
  final List<Ingredient> ingredients; // можно убрать
}
