import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String categoryId;
  final String name;
  final String description;
  final int price;
  final String? badge;

  const Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    this.badge,
  });

  factory Product.fromFireStore(
    DocumentSnapshot snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError("Document is empty: ${snapshot.id}");
    }

    return Product.fromMap(data);
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'].toString(),
      categoryId: map['category_id'].toString(),
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
      badge: map['badge'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'price': price,
      if (badge != null) 'badge': badge,
    };
  }
}
