import 'package:pizza_app/features/product_details/data/models/product_details.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/product_details_repository_interface.dart';

class InmemoryProductDetailsRepository implements IProductDetailsRepository {
  final Map<String, ProductDetails> _store;

  InmemoryProductDetailsRepository({Map<String, ProductDetails>? store})
    : _store = store ?? {};

  @override
  Future<ProductDetails?> getProductDetails(String id) {
    return Future.syncValue(_store[id]);
  }
}
