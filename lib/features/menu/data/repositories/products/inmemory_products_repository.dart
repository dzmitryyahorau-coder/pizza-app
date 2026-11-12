import 'package:pizza_app/features/menu/data/models/product.dart';
import 'package:pizza_app/features/menu/domain/repositories/products/products_repository_interface.dart';

class InmemoryProductsRepository implements IProductsRepository {
  final List<Product> _store;

  InmemoryProductsRepository({List<Product>? store}) : _store = store ?? [];

  @override
  Future<List<Product>> getProducts() {
    return Future.sync(() => _store);
  }
}
