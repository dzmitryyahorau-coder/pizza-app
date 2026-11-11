import 'package:pizza_app/features/product_details/data/models/topping.dart';
import 'package:pizza_app/features/product_details/data/repository/toppings/interface_topings_repository.dart';

class InmemoryToppingsRepository implements IToppingsRepository {
  final List<Topping> _store;

  InmemoryToppingsRepository({List<Topping>? store}) : _store = store ?? [];

  @override
  Future<List<Topping>> getToppings() {
    return Future.syncValue(_store);
  }
}
