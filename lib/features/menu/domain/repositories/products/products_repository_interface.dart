import 'package:pizza_app/features/menu/data/models/product.dart';

abstract interface class IProductsRepository {
  Future<List<Product>> getProducts();
}
