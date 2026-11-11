import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_app/features/product_details/data/models/dough.dart';
import 'package:pizza_app/features/product_details/data/models/ingredient.dart';
import 'package:pizza_app/features/product_details/data/models/product_size.dart';
import 'package:pizza_app/features/product_details/data/models/topping.dart';

class ProductDetails {
  ProductDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.imageAsset,
    required this.sizes,
    required this.defaultSizeId,
    required this.doughs,
    required this.defaultDoughId,
    required this.toppings,
    required this.ingredients,
  }) {
    for (final topping in toppings) {
      mapToppingsById[topping.id] = topping;
    }

    for (final ingredient in ingredients) {
      mapIngredientById[ingredient.id] = ingredient;
    }
  }

  final String id;
  final String name;
  final String description;
  final String imageAsset;
  final List<ProductSize> sizes;
  final String defaultSizeId;
  final List<Dough> doughs;
  final String defaultDoughId;
  final List<Topping> toppings;
  final List<Ingredient> ingredients;

  final Map<String, Topping> mapToppingsById = {};
  final Map<String, Ingredient> mapIngredientById = {};

  factory ProductDetails.fromFirestore(
    DocumentSnapshot snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      return throw StateError("Document is empty: ${snapshot.id}");
    }

    return ProductDetails.fromMap(data);
  }

  factory ProductDetails.fromMap(Map<String, dynamic> map) {
    List<T> parseList<T>(
      dynamic rawList,
      T Function(Map<String, dynamic>) fromMap,
    ) {
      if (rawList is! List) return const [];
      return rawList
          .whereType()
          .map((item) => fromMap(Map<String, dynamic>.from(item)))
          .toList();
    }

    final sizes = parseList(map['sizes'], ProductSize.fromMap);
    final doughs = parseList(map['doughs'], Dough.fromMap);
    final toppings = parseList(map['toppings'], Topping.fromMap);
    final ingredients = parseList(map['ingredients'], Ingredient.fromMap);

    return ProductDetails(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      imageAsset: map['imageAsset']?.toString() ?? '',
      sizes: sizes,
      defaultSizeId:
          map['defaultSizeId']?.toString() ??
          (sizes.isNotEmpty ? sizes.first.id : ''),
      doughs: doughs,
      defaultDoughId:
          map['defaultDoughId']?.toString() ??
          (doughs.isNotEmpty ? doughs.first.id : ''),
      toppings: toppings,
      ingredients: ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageAsset': imageAsset,
      'sizes': sizes.map((s) => s.toMap()).toList(),
      'defaultSizeId': defaultSizeId,
      'doughs': doughs.map((d) => d.toMap()).toList(),
      'defaultDoughId': defaultDoughId,
      'toppings': toppings.map((t) => t.toMap()).toList(),
      'ingredients': ingredients.map((i) => i.toMap()).toList(),
    };
  }
}
