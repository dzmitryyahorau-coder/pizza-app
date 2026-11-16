import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  const Ingredient({
    required this.id,
    required this.ingredientKey,
    this.imgPath,
  });

  final String id;
  final String ingredientKey;
  final String? imgPath;

  factory Ingredient.fromFireStore(
    DocumentSnapshot snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError("Document is empty: ${snapshot.id}");
    }

    return Ingredient.fromMap(data);
  }

  factory Ingredient.fromMap(Map<String, dynamic> data) {
    return Ingredient(
      id: data['id']?.toString() ?? '',
      ingredientKey: data['ingredient_key']?.toString() ?? '',
      imgPath: data['imgPath']?.toString(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'ingredient_key': ingredientKey,
    if (imgPath != null) 'imgPath': imgPath,
  };
}
