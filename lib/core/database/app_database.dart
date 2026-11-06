import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/cart_items.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [CartItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'pizza_app_db');
  }

  Stream<List<CartItem>> watchCartItems() => select(cartItems).watch();

  Future<int> addItem(CartItemsCompanion item) async {
    final existing =
        await (select(cartItems)..where(
              (tbl) =>
                  tbl.productId.equals(item.productId.value) &
                  tbl.sizeName.equalsNullable(item.sizeName.value) &
                  tbl.doughName.equalsNullable(item.doughName.value) &
                  tbl.selectedToppingsJson.equals(
                    item.selectedToppingsJson.value,
                  ),
            ))
            .getSingleOrNull();

    if (existing != null) {
      final updatedQuantity = existing.quantity + item.quantity.value;
      await updateQuantity(existing.id, updatedQuantity);
      return existing.id;
    } else {
      return into(cartItems).insert(item);
    }
  }

  Future<void> updateQuantity(int id, int quantity) async {
    if (quantity <= 0) {
      await deleteItem(id);
    } else {
      await (update(cartItems)..where((tbl) => tbl.id.equals(id))).write(
        CartItemsCompanion(quantity: Value(quantity)),
      );
    }
  }

  Future<int> deleteItem(int id) =>
      (delete(cartItems)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> clearCart() => delete(cartItems).go();
}
