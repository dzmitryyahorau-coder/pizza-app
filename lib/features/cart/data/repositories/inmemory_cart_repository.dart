import 'dart:async';

import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/features/cart/data/repositories/cart_repository_interface.dart';

typedef CartStore = List<CartItem>;

class InmemoryCartRepository implements ICartRepository {
  final CartStore _store;

  final StreamController<CartStore> _controller =
      StreamController<CartStore>.broadcast();

  InmemoryCartRepository({CartStore? store}) : _store = store ?? [] {
    _emit();
  }

  void _emit() {
    _controller.add(List.unmodifiable(_store));
  }

  @override
  Future<void> addToCart(CartItem item) async {
    final id = _store.length + 1;
    CartItem newItem = item.copyWith(id: id);

    _store.add(newItem);
    _emit();
  }

  @override
  Future<void> clearCart() async {
    _store.clear();
    _emit();
  }

  @override
  Future<void> updateQuantity(int id, int quantity) async {
    final found = _store.firstWhere((item) => item.id == id);
    final index = _store.indexOf(found);

    _store[index] = found.copyWith(quantity: quantity);
    _emit();
  }

  @override
  Stream<List<CartItem>> watchCart() {
    return _controller.stream;
  }
}
