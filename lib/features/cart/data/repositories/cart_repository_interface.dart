import 'package:pizza_app/core/database/app_database.dart';

abstract interface class ICartRepository {
  Stream<List<CartItem>> watchCart();
  Future<void> addToCart(CartItem item);
  Future<void> updateQuantity(int id, int quantity);
  Future<void> clearCart();
}
