import 'package:cloud_firestore/cloud_firestore.dart';

class Topping {
  const Topping({
    required this.id,
    required this.toppingKey,
    required this.weightGrams,
    required this.price,
    required this.imageAsset,
  });

  final String id;
  final String toppingKey;
  final int weightGrams;
  final int price;
  final String imageAsset;

  factory Topping.fromFireStore(
    DocumentSnapshot snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('Empty state');
    }

    return Topping.fromMap(data);
  }

  factory Topping.fromMap(Map<String, dynamic> data) {
    return Topping(
      id: data['id']?.toString() ?? '',
      toppingKey: data['toppings_key']?.toString() ?? '',
      weightGrams: (data['weight_grams'] as num?)?.toInt() ?? 0,
      price: (data['price'] as num?)?.toInt() ?? 0,
      imageAsset: data['image_asset']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'toppings_key': toppingKey,
    'weightGrams': weightGrams,
    'price': price,
    'imageAsset': imageAsset,
  };
}
