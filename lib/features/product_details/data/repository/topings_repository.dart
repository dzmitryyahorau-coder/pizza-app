import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pizza_app/features/product_details/data/models/topping.dart';

abstract interface class IToppingsRepository {
  Future<List<Topping>> getToppings();
}

class FirestoreToppingsRepository implements IToppingsRepository {
  final FirebaseFirestore _firestore;

  FirestoreToppingsRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Topping> get _collection => _firestore
      .collection('toppings')
      .withConverter<Topping>(
        fromFirestore: ((snapshot, options) =>
            Topping.fromFireStore(snapshot, options)),
        toFirestore: (product, _) => product.toFireStore(),
      );

  @override
  Future<List<Topping>> getToppings() async {
    try {
      Query<Topping> query = _collection;

      final querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e, st) {
      debugPrint(
        'Failed getting the Toppings from Firestore: ${e.message}\n$st\n',
      );
      rethrow;
    } catch (e, st) {
      debugPrint(
        'Invalid result FirestoreToppingsRepository.getToppings(): $e\n$st',
      );
      rethrow;
    }
  }
}
