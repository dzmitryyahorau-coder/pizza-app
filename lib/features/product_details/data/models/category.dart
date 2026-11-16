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

    return Category.fromMap(data);
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'].toString(),
      name: map['category_key'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
