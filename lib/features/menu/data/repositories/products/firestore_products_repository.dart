import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_app/features/menu/data/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:pizza_app/features/menu/domain/repositories/products/products_repository_interface.dart';

class FirestoreProductsRepository implements IProductsRepository {
  final FirebaseFirestore _firestore;

  FirestoreProductsRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Product> get _collection => _firestore
      .collection('products')
      .withConverter<Product>(
        fromFirestore: ((snapshot, options) =>
            Product.fromFireStore(snapshot, options)),
        toFirestore: (product, _) => product.toMap(),
      );

  @override
  Future<List<Product>> getProducts() async {
    try {
      Query<Product> query = _collection;

      final querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e, st) {
      debugPrint(
        'Failed getting the products from Firestore: ${e.message}\n$st\n',
      );
      rethrow;
    } catch (e, st) {
      debugPrint(
        'Invalid result FirestoreProductRepository.getProducts(): $e\n$st',
      );
      rethrow;
    }
  }
}
