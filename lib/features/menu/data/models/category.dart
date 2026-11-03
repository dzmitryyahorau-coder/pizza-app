import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  const Category({required this.id, required this.name});

  final String id;
  final String name;

  factory Category.fromFireStore(
    DocumentSnapshot snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError("Document is empty: ${snapshot.id}");
    }

    return Category(
      id: data['id'] as String? ?? '',
      name: data['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'id': id, 'name': name};
  }
}
