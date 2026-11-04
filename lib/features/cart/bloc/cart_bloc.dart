import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/features/cart/bloc/cart_state.dart';
import 'package:pizza_app/features/cart/data/repositories/cart_repository.dart';

class CartCubit extends Cubit<CartState> {
  final ICartRepository _repository;
  StreamSubscription? _cartSubscription;

  CartCubit(this._repository) : super(const CartState()) {
    _cartSubscription = _repository.watchCart().listen((items) {
      final total = items.fold<int>(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );

      emit(CartState(items: items, totalPrice: total));
    });
  }

  void addToCart(CartItem item) => _repository.addToCart(item);

  void clearCart() => _repository.clearCart();

  void updateQuantity(int id, int quantity) =>
      _repository.updateQuantity(id, quantity);

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}
