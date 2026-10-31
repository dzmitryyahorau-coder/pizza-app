import 'package:pizza_app/features/product_details/data/dough.dart';
import 'package:pizza_app/features/product_details/data/ingredient.dart';
import 'package:pizza_app/features/product_details/data/topping.dart';
import 'package:pizza_app/features/product_details/data/product_size.dart';

class ProductDetails {
  ProductDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.imageAsset,
    required this.sizes,
    required this.defaultSizeId,
    required this.dough,
    required this.toppings,
    required this.ingredients,
  });

  final String id;
  final String name;
  final String description;
  final String imageAsset;
  final List<ProductSize> sizes;
  final String defaultSizeId;
  Dough dough;
  final List<Topping> toppings;
  final List<Ingredient> ingredients; // можно убрать
}
