import 'package:pizza_app/core/database/app_database.dart';

abstract class CartMockData {
  static final List<CartItem> cartItems = [
    const CartItem(
      id: 1,
      productId: 'p3',
      name: 'Пепперони',
      imageAsset: 'assets/images/pizza.png',
      price: 2890,
      quantity: 1,
      sizeName: '30 см',
      doughName: 'традиционное',
      selectedToppingsJson: '[]',
    ),
    const CartItem(
      id: 2,
      productId: 'p2',
      name: 'Сырный цыпленок',
      imageAsset: 'assets/images/pizza.png',
      price: 1950,
      quantity: 2,
      sizeName: '25 см',
      doughName: 'тонкое',
      selectedToppingsJson: '[]',
    ),
  ];
}
