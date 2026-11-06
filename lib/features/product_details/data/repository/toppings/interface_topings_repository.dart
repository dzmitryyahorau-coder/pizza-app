import 'package:pizza_app/features/product_details/data/models/topping.dart';

abstract interface class IToppingsRepository {
  Future<List<Topping>> getToppings();
}
