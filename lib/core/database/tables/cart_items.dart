import 'package:drift/drift.dart';

class CartItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productId => text()();
  TextColumn get name => text()();
  TextColumn get imageAsset => text()();
  IntColumn get price => integer()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  TextColumn get sizeName => text().nullable()();
  TextColumn get doughName => text().nullable()();
  TextColumn get selectedToppingsJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get removedIngredientsJson =>
      text().withDefault(const Constant('[]'))();
}
