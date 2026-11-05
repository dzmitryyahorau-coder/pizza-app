import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_app/features/menu/data/models/category.dart';
import 'package:flutter/foundation.dart' hide Category;

abstract interface class ICategoriesRepository {
  Future<List<Category>> getCategories();
}

class FirestoreCategoriesRepository implements ICategoriesRepository {
  final FirebaseFirestore _firestore;

  FirestoreCategoriesRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Category> get _collection => _firestore
      .collection('categories')
      .withConverter<Category>(
        fromFirestore: ((snapshot, options) =>
            Category.fromFireStore(snapshot, options)),
        toFirestore: (category, _) => category.toMap(),
      );

  @override
  Future<List<Category>> getCategories() async {
    try {
      Query<Category> query = _collection;

      final querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e, st) {
      debugPrint(
        'Failed getting the categories from Firestore: ${e.message}\n$st\n',
      );
      rethrow;
    } catch (e, st) {
      debugPrint(
        'Invalid result FirestoreCategoryRepository.getCategories(): $e\n$st',
      );
      rethrow;
    }
  }
}
