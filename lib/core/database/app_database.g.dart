// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CartItemsTable extends CartItems
    with TableInfo<$CartItemsTable, CartItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageAssetMeta = const VerificationMeta(
    'imageAsset',
  );
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
    'image_asset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _sizeNameMeta = const VerificationMeta(
    'sizeName',
  );
  @override
  late final GeneratedColumn<String> sizeName = GeneratedColumn<String>(
    'size_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doughNameMeta = const VerificationMeta(
    'doughName',
  );
  @override
  late final GeneratedColumn<String> doughName = GeneratedColumn<String>(
    'dough_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _selectedToppingsJsonMeta =
      const VerificationMeta('selectedToppingsJson');
  @override
  late final GeneratedColumn<String> selectedToppingsJson =
      GeneratedColumn<String>(
        'selected_toppings_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _removedIngredientsJsonMeta =
      const VerificationMeta('removedIngredientsJson');
  @override
  late final GeneratedColumn<String> removedIngredientsJson =
      GeneratedColumn<String>(
        'removed_ingredients_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    name,
    imageAsset,
    price,
    quantity,
    sizeName,
    doughName,
    selectedToppingsJson,
    removedIngredientsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_asset')) {
      context.handle(
        _imageAssetMeta,
        imageAsset.isAcceptableOrUnknown(data['image_asset']!, _imageAssetMeta),
      );
    } else if (isInserting) {
      context.missing(_imageAssetMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('size_name')) {
      context.handle(
        _sizeNameMeta,
        sizeName.isAcceptableOrUnknown(data['size_name']!, _sizeNameMeta),
      );
    }
    if (data.containsKey('dough_name')) {
      context.handle(
        _doughNameMeta,
        doughName.isAcceptableOrUnknown(data['dough_name']!, _doughNameMeta),
      );
    }
    if (data.containsKey('selected_toppings_json')) {
      context.handle(
        _selectedToppingsJsonMeta,
        selectedToppingsJson.isAcceptableOrUnknown(
          data['selected_toppings_json']!,
          _selectedToppingsJsonMeta,
        ),
      );
    }
    if (data.containsKey('removed_ingredients_json')) {
      context.handle(
        _removedIngredientsJsonMeta,
        removedIngredientsJson.isAcceptableOrUnknown(
          data['removed_ingredients_json']!,
          _removedIngredientsJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_asset'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      sizeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size_name'],
      ),
      doughName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dough_name'],
      ),
      selectedToppingsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_toppings_json'],
      )!,
      removedIngredientsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}removed_ingredients_json'],
      )!,
    );
  }

  @override
  $CartItemsTable createAlias(String alias) {
    return $CartItemsTable(attachedDatabase, alias);
  }
}

class CartItem extends DataClass implements Insertable<CartItem> {
  final int id;
  final String productId;
  final String name;
  final String imageAsset;
  final int price;
  final int quantity;
  final String? sizeName;
  final String? doughName;
  final String selectedToppingsJson;
  final String removedIngredientsJson;
  const CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.imageAsset,
    required this.price,
    required this.quantity,
    this.sizeName,
    this.doughName,
    required this.selectedToppingsJson,
    required this.removedIngredientsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<String>(productId);
    map['name'] = Variable<String>(name);
    map['image_asset'] = Variable<String>(imageAsset);
    map['price'] = Variable<int>(price);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || sizeName != null) {
      map['size_name'] = Variable<String>(sizeName);
    }
    if (!nullToAbsent || doughName != null) {
      map['dough_name'] = Variable<String>(doughName);
    }
    map['selected_toppings_json'] = Variable<String>(selectedToppingsJson);
    map['removed_ingredients_json'] = Variable<String>(removedIngredientsJson);
    return map;
  }

  CartItemsCompanion toCompanion(bool nullToAbsent) {
    return CartItemsCompanion(
      id: Value(id),
      productId: Value(productId),
      name: Value(name),
      imageAsset: Value(imageAsset),
      price: Value(price),
      quantity: Value(quantity),
      sizeName: sizeName == null && nullToAbsent
          ? const Value.absent()
          : Value(sizeName),
      doughName: doughName == null && nullToAbsent
          ? const Value.absent()
          : Value(doughName),
      selectedToppingsJson: Value(selectedToppingsJson),
      removedIngredientsJson: Value(removedIngredientsJson),
    );
  }

  factory CartItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartItem(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      name: serializer.fromJson<String>(json['name']),
      imageAsset: serializer.fromJson<String>(json['imageAsset']),
      price: serializer.fromJson<int>(json['price']),
      quantity: serializer.fromJson<int>(json['quantity']),
      sizeName: serializer.fromJson<String?>(json['sizeName']),
      doughName: serializer.fromJson<String?>(json['doughName']),
      selectedToppingsJson: serializer.fromJson<String>(
        json['selectedToppingsJson'],
      ),
      removedIngredientsJson: serializer.fromJson<String>(
        json['removedIngredientsJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<String>(productId),
      'name': serializer.toJson<String>(name),
      'imageAsset': serializer.toJson<String>(imageAsset),
      'price': serializer.toJson<int>(price),
      'quantity': serializer.toJson<int>(quantity),
      'sizeName': serializer.toJson<String?>(sizeName),
      'doughName': serializer.toJson<String?>(doughName),
      'selectedToppingsJson': serializer.toJson<String>(selectedToppingsJson),
      'removedIngredientsJson': serializer.toJson<String>(
        removedIngredientsJson,
      ),
    };
  }

  CartItem copyWith({
    int? id,
    String? productId,
    String? name,
    String? imageAsset,
    int? price,
    int? quantity,
    Value<String?> sizeName = const Value.absent(),
    Value<String?> doughName = const Value.absent(),
    String? selectedToppingsJson,
    String? removedIngredientsJson,
  }) => CartItem(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    name: name ?? this.name,
    imageAsset: imageAsset ?? this.imageAsset,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
    sizeName: sizeName.present ? sizeName.value : this.sizeName,
    doughName: doughName.present ? doughName.value : this.doughName,
    selectedToppingsJson: selectedToppingsJson ?? this.selectedToppingsJson,
    removedIngredientsJson:
        removedIngredientsJson ?? this.removedIngredientsJson,
  );
  CartItem copyWithCompanion(CartItemsCompanion data) {
    return CartItem(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      name: data.name.present ? data.name.value : this.name,
      imageAsset: data.imageAsset.present
          ? data.imageAsset.value
          : this.imageAsset,
      price: data.price.present ? data.price.value : this.price,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      sizeName: data.sizeName.present ? data.sizeName.value : this.sizeName,
      doughName: data.doughName.present ? data.doughName.value : this.doughName,
      selectedToppingsJson: data.selectedToppingsJson.present
          ? data.selectedToppingsJson.value
          : this.selectedToppingsJson,
      removedIngredientsJson: data.removedIngredientsJson.present
          ? data.removedIngredientsJson.value
          : this.removedIngredientsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartItem(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('price: $price, ')
          ..write('quantity: $quantity, ')
          ..write('sizeName: $sizeName, ')
          ..write('doughName: $doughName, ')
          ..write('selectedToppingsJson: $selectedToppingsJson, ')
          ..write('removedIngredientsJson: $removedIngredientsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    name,
    imageAsset,
    price,
    quantity,
    sizeName,
    doughName,
    selectedToppingsJson,
    removedIngredientsJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItem &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.name == this.name &&
          other.imageAsset == this.imageAsset &&
          other.price == this.price &&
          other.quantity == this.quantity &&
          other.sizeName == this.sizeName &&
          other.doughName == this.doughName &&
          other.selectedToppingsJson == this.selectedToppingsJson &&
          other.removedIngredientsJson == this.removedIngredientsJson);
}

class CartItemsCompanion extends UpdateCompanion<CartItem> {
  final Value<int> id;
  final Value<String> productId;
  final Value<String> name;
  final Value<String> imageAsset;
  final Value<int> price;
  final Value<int> quantity;
  final Value<String?> sizeName;
  final Value<String?> doughName;
  final Value<String> selectedToppingsJson;
  final Value<String> removedIngredientsJson;
  const CartItemsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.name = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.price = const Value.absent(),
    this.quantity = const Value.absent(),
    this.sizeName = const Value.absent(),
    this.doughName = const Value.absent(),
    this.selectedToppingsJson = const Value.absent(),
    this.removedIngredientsJson = const Value.absent(),
  });
  CartItemsCompanion.insert({
    this.id = const Value.absent(),
    required String productId,
    required String name,
    required String imageAsset,
    required int price,
    this.quantity = const Value.absent(),
    this.sizeName = const Value.absent(),
    this.doughName = const Value.absent(),
    this.selectedToppingsJson = const Value.absent(),
    this.removedIngredientsJson = const Value.absent(),
  }) : productId = Value(productId),
       name = Value(name),
       imageAsset = Value(imageAsset),
       price = Value(price);
  static Insertable<CartItem> custom({
    Expression<int>? id,
    Expression<String>? productId,
    Expression<String>? name,
    Expression<String>? imageAsset,
    Expression<int>? price,
    Expression<int>? quantity,
    Expression<String>? sizeName,
    Expression<String>? doughName,
    Expression<String>? selectedToppingsJson,
    Expression<String>? removedIngredientsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (name != null) 'name': name,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (price != null) 'price': price,
      if (quantity != null) 'quantity': quantity,
      if (sizeName != null) 'size_name': sizeName,
      if (doughName != null) 'dough_name': doughName,
      if (selectedToppingsJson != null)
        'selected_toppings_json': selectedToppingsJson,
      if (removedIngredientsJson != null)
        'removed_ingredients_json': removedIngredientsJson,
    });
  }

  CartItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? productId,
    Value<String>? name,
    Value<String>? imageAsset,
    Value<int>? price,
    Value<int>? quantity,
    Value<String?>? sizeName,
    Value<String?>? doughName,
    Value<String>? selectedToppingsJson,
    Value<String>? removedIngredientsJson,
  }) {
    return CartItemsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      imageAsset: imageAsset ?? this.imageAsset,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      sizeName: sizeName ?? this.sizeName,
      doughName: doughName ?? this.doughName,
      selectedToppingsJson: selectedToppingsJson ?? this.selectedToppingsJson,
      removedIngredientsJson:
          removedIngredientsJson ?? this.removedIngredientsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (sizeName.present) {
      map['size_name'] = Variable<String>(sizeName.value);
    }
    if (doughName.present) {
      map['dough_name'] = Variable<String>(doughName.value);
    }
    if (selectedToppingsJson.present) {
      map['selected_toppings_json'] = Variable<String>(
        selectedToppingsJson.value,
      );
    }
    if (removedIngredientsJson.present) {
      map['removed_ingredients_json'] = Variable<String>(
        removedIngredientsJson.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartItemsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('price: $price, ')
          ..write('quantity: $quantity, ')
          ..write('sizeName: $sizeName, ')
          ..write('doughName: $doughName, ')
          ..write('selectedToppingsJson: $selectedToppingsJson, ')
          ..write('removedIngredientsJson: $removedIngredientsJson')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CartItemsTable cartItems = $CartItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cartItems];
}

typedef $$CartItemsTableCreateCompanionBuilder = CartItemsCompanion Function({
  Value<int> id,
  required String productId,
  required String name,
  required String imageAsset,
  required int price,
  Value<int> quantity,
  Value<String?> sizeName,
  Value<String?> doughName,
  Value<String> selectedToppingsJson,
  Value<String> removedIngredientsJson,
});
typedef $$CartItemsTableUpdateCompanionBuilder = CartItemsCompanion Function({
  Value<int> id,
  Value<String> productId,
  Value<String> name,
  Value<String> imageAsset,
  Value<int> price,
  Value<int> quantity,
  Value<String?> sizeName,
  Value<String?> doughName,
  Value<String> selectedToppingsJson,
  Value<String> removedIngredientsJson,
});

class $$CartItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sizeName => $composableBuilder(
    column: $table.sizeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doughName => $composableBuilder(
    column: $table.doughName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedToppingsJson => $composableBuilder(
    column: $table.selectedToppingsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get removedIngredientsJson => $composableBuilder(
    column: $table.removedIngredientsJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CartItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sizeName => $composableBuilder(
    column: $table.sizeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doughName => $composableBuilder(
    column: $table.doughName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedToppingsJson => $composableBuilder(
    column: $table.selectedToppingsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get removedIngredientsJson => $composableBuilder(
    column: $table.removedIngredientsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CartItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageAsset => $composableBuilder(
    column: $table.imageAsset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get sizeName =>
      $composableBuilder(column: $table.sizeName, builder: (column) => column);

  GeneratedColumn<String> get doughName =>
      $composableBuilder(column: $table.doughName, builder: (column) => column);

  GeneratedColumn<String> get selectedToppingsJson => $composableBuilder(
    column: $table.selectedToppingsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get removedIngredientsJson => $composableBuilder(
    column: $table.removedIngredientsJson,
    builder: (column) => column,
  );
}

class $$CartItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CartItemsTable,
          CartItem,
          $$CartItemsTableFilterComposer,
          $$CartItemsTableOrderingComposer,
          $$CartItemsTableAnnotationComposer,
          $$CartItemsTableCreateCompanionBuilder,
          $$CartItemsTableUpdateCompanionBuilder,
          (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
          CartItem,
          PrefetchHooks Function()
        > {
  $$CartItemsTableTableManager(_$AppDatabase db, $CartItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> imageAsset = const Value.absent(),
                Value<int> price = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> sizeName = const Value.absent(),
                Value<String?> doughName = const Value.absent(),
                Value<String> selectedToppingsJson = const Value.absent(),
                Value<String> removedIngredientsJson = const Value.absent(),
              }) => CartItemsCompanion(
                id: id,
                productId: productId,
                name: name,
                imageAsset: imageAsset,
                price: price,
                quantity: quantity,
                sizeName: sizeName,
                doughName: doughName,
                selectedToppingsJson: selectedToppingsJson,
                removedIngredientsJson: removedIngredientsJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String productId,
                required String name,
                required String imageAsset,
                required int price,
                Value<int> quantity = const Value.absent(),
                Value<String?> sizeName = const Value.absent(),
                Value<String?> doughName = const Value.absent(),
                Value<String> selectedToppingsJson = const Value.absent(),
                Value<String> removedIngredientsJson = const Value.absent(),
              }) => CartItemsCompanion.insert(
                id: id,
                productId: productId,
                name: name,
                imageAsset: imageAsset,
                price: price,
                quantity: quantity,
                sizeName: sizeName,
                doughName: doughName,
                selectedToppingsJson: selectedToppingsJson,
                removedIngredientsJson: removedIngredientsJson,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CartItemsTable, CartItem>(table),
                  BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CartItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CartItemsTable,
      CartItem,
      $$CartItemsTableFilterComposer,
      $$CartItemsTableOrderingComposer,
      $$CartItemsTableAnnotationComposer,
      $$CartItemsTableCreateCompanionBuilder,
      $$CartItemsTableUpdateCompanionBuilder,
      (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
      CartItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CartItemsTableTableManager get cartItems =>
      $$CartItemsTableTableManager(_db, _db.cartItems);
}
