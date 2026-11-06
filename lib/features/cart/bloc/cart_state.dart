import 'package:pizza_app/core/database/app_database.dart';

class CartState {
  final List<CartItem> items;
  final int totalPrice;

  const CartState({this.items = const [], this.totalPrice = 0});
}
