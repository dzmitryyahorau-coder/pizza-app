import 'package:cloud_firestore/cloud_firestore.dart';

class Dough {
  const Dough({
    required this.id,
    required this.name,
    required this.imageAsset,
    this.extraPrice = 0,
  });

  final String id;
  final String name;
  final String imageAsset;
  final int extraPrice;

  factory Dough.fromFireStore(DocumentSnapshot snapshot, SnapshotOptions? options) {
    final data = snapshot.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('Empty state');
    }

    
    return Dough.fromMap(data);
  }

  factory Dough.fromMap(Map<String, dynamic> data) {
    return Dough(
      id: data['id']?.toString() ?? '',
      name: data['name']?.toString() ?? '',
      imageAsset: data['imageAsset']?.toString() ?? '',
      extraPrice: (data['extraPrice'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toFireStore() => {
    'id': id,
    'name': name,
    'imageAsset': imageAsset,
    'extraPrice': extraPrice,
  };
}
