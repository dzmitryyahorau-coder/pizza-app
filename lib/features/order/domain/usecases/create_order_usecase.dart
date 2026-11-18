import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/core/domain/usecase.dart';
import 'package:pizza_app/features/delivery/data/models/address.dart';
import 'package:pizza_app/features/order/data/models/order.dart';
import 'package:pizza_app/features/order/data/models/order_item.dart';
import 'package:pizza_app/features/order/domain/exceptions/empty_cart_exception.dart';
import 'package:pizza_app/features/order/domain/repositories/order_repository_interface.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:pizza_app/shared/auth/exceptions/not_authenticated_exception.dart';

class CreateOrderParams {
  final List<CartItem> items;
  final Address address;

  CreateOrderParams({required this.items, required this.address});
}

class CreateOrderUsecase extends Usecase<void, CreateOrderParams> {
  final IOrderRepository _orderRepository;
  final CurrentUserStore _currentUserStore;

  CreateOrderUsecase({
    required this._orderRepository,
    required this._currentUserStore,
  });

  List<Map<String, dynamic>> _decodeList(String json) {
    final decoded = jsonDecode(json);
    if (decoded is! List) return const [];
    return decoded
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  @override
  Future<void> call(CreateOrderParams params) async {
    try {
      if (params.items.isEmpty) throw EmptyCartException();
      final userId = _currentUserStore.value?.id;
      if (userId == null) throw NotAuthenticatedException();

      final totalPrice = params.items.fold(
        0,
        (acc, currentValue) => acc + currentValue.price * currentValue.quantity,
      );

      final orderItems = params.items
          .map(
            (cartItem) => OrderItem(
              productId: cartItem.productId,
              name: cartItem.name,
              unitPrice: cartItem.price,
              quantity: cartItem.quantity,
              sizeName: cartItem.sizeName,
              doughName: cartItem.doughName,
              imageAsset: cartItem.imageAsset,
              toppings: _decodeList(cartItem.selectedToppingsJson),
              removedIngredients: _decodeList(cartItem.removedIngredientsJson),
            ),
          )
          .toList();
      final order = Order(
        userId: userId,
        totalPrice: totalPrice,
        city: params.address.city,
        street: params.address.street,
        house: params.address.house,
        latitude: params.address.latitude,
        longitude: params.address.longitude,
        addressId: params.address.id,
        entrance: params.address.entrance,
        intercom: params.address.intercom,
        floor: params.address.floor,
        apartment: params.address.apartment,
        courierComment: params.address.courierComment,
        items: orderItems,
      );

      await _orderRepository.create(order);
    } catch (e) {
      debugPrint('Failed to create order: $e');
      rethrow;
    }
  }
}
