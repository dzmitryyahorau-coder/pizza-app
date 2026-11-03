import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pizza_app/features/product_details/data/models/product_details.dart';

abstract interface class IProductDetailsRepository {
  Future<ProductDetails?> getProductDetails(String id);
}

class FirestoreProductDetailsRepository implements IProductDetailsRepository {
  final FirebaseFirestore _firestore;

  FirestoreProductDetailsRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<ProductDetails?> getProductDetails(String id) async {
    try {
      final doc = await _firestore
          .collection('products')
          .doc(id)
          .withConverter<ProductDetails>(
            fromFirestore: ProductDetails.fromFirestore,
            toFirestore: (details, _) => details.toFirestore(),
          )
          .get();

      return doc.data();
    } on FirebaseException catch (e, st) {
      debugPrint(
        'Failed getting the products from Firestore: ${e.message}\n$st\n',
      );
      rethrow;
    } catch (e, st) {
      debugPrint(
        'Invalid result FirestoreProductDetailsRepository.getProductDetails(): $e\n$st',
      );
      rethrow;
    }
  }
}
