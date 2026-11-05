import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pizza_app/features/product_details/data/models/ingredient.dart';

abstract interface class IIngredientsRepository {
  Future<List<Ingredient>> getIngredients();
}

class FirestoreIngredientsRepository implements IIngredientsRepository {
  final FirebaseFirestore _firestore;

  FirestoreIngredientsRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Ingredient> get _collection => _firestore
      .collection('ingredients')
      .withConverter<Ingredient>(
        fromFirestore: ((snapshot, options) =>
            Ingredient.fromFireStore(snapshot, options)),
        toMap: (product, _) => product.toMap(),
      );

  @override
  Future<List<Ingredient>> getIngredients() async {
    try {
      Query<Ingredient> query = _collection;

      final querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e, st) {
      debugPrint(
        'Failed getting the ingredients from Firestore: ${e.message}\n$st\n',
      );
      rethrow;
    } catch (e, st) {
      debugPrint(
        'Invalid result FirestoreIngredientRepository.getIngredients(): $e\n$st',
      );
      rethrow;
    }
  }
}
