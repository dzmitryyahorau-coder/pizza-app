import 'package:cloud_firestore/cloud_firestore.dart';

class Dough {
  const Dough({
    required this.id,
    required this.nameKey,
    required this.imageAsset,
    this.extraPrice = 0,
  });

  final String id;
  final String nameKey;
  final String imageAsset;
  final int extraPrice;

  factory Dough.fromFireStore(
    DocumentSnapshot snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('Empty state');
    }

    return Dough.fromMap(data);
  }

  factory Dough.fromMap(Map<String, dynamic> data) {
    return Dough(
      id: data['id']?.toString() ?? '',
      nameKey: data['name_key']?.toString() ?? '',
      imageAsset: data['image_asset']?.toString() ?? '',
      extraPrice: (data['extra_price'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name_key': nameKey,
    'image_asset': imageAsset,
    'extra_price': extraPrice,
  };
}
