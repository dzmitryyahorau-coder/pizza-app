import 'package:pizza_app/features/order/data/models/order.dart';

abstract interface class IOrderRepository {
  Future<void> create(Order order);
}
