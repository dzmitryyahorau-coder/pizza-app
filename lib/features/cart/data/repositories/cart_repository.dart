import 'package:pizza_app/core/database/app_database.dart';

abstract interface class ICartRepository {
  Stream<List<CartItem>> watchCart();
  Future<void> addToCart(CartItem item);
  Future<void> updateQuantity(int id, int quantity);
}

class DriftCartRepository implements ICartRepository {
  final AppDatabase _db;

  DriftCartRepository(this._db);

  @override
  Future<void> addToCart(CartItem item) => _db.addItem(item.toCompanion(false));

  @override
  Future<void> updateQuantity(int id, int quantity) =>
      _db.updateQuantity(id, quantity);

  @override
  Stream<List<CartItem>> watchCart() => _db.watchCartItems();
}
