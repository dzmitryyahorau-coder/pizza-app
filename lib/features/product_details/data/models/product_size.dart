import 'package:cloud_firestore/cloud_firestore.dart';

class ProductSize {
  const ProductSize({required this.id, required this.cm, required this.price});

  final String id;
  final int cm;
  final int price;

  factory ProductSize.fromFireStore(
    DocumentSnapshot snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('Empty state');
    }

    return ProductSize.fromMap(data);
  }

  factory ProductSize.fromMap(Map<String, dynamic> data) {
    return ProductSize(
      id: data['id']?.toString() ?? '',
      cm: (data['cm'] as num?)?.toInt() ?? 0,
      price: (data['price'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {'id': id, 'cm': cm, 'price': price};

  @override
  bool operator ==(Object other) {
    return other is ProductSize && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
