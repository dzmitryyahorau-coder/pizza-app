class OrderItem {
  const OrderItem({
    this.id,
    this.orderId,
    required this.productId,
    required this.name,
    this.imageAsset,
    this.sizeName,
    this.doughName,
    required this.unitPrice,
    required this.quantity,
    this.toppings = const [],
    this.removedIngredients = const [],
  });

  final String? id;
  final String? orderId;
  final String productId;
  final String name;
  final String? imageAsset;
  final String? sizeName;
  final String? doughName;
  final int unitPrice;
  final int quantity;
  final List<Map<String, dynamic>> toppings;
  final List<Map<String, dynamic>> removedIngredients;

  int get totalPrice => unitPrice * quantity;

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'] as String?,
      orderId: map['order_id'] as String?,
      productId: map['product_id'].toString(),
      name: map['name'] as String,
      imageAsset: map['image_asset'] as String?,
      sizeName: map['size_name'] as String?,
      doughName: map['dough_name'] as String?,
      unitPrice: (map['unit_price'] as num).toInt(),
      quantity: map['quantity'] as int,
      toppings: _toMapList(map['toppings']),
      removedIngredients: _toMapList(map['removed_ingredients']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      'product_id': productId,
      'name': name,
      'image_asset': imageAsset,
      'size_name': sizeName,
      'dough_name': doughName,
      'unit_price': unitPrice,
      'quantity': quantity,
      'toppings': toppings,
      'removed_ingredients': removedIngredients,
    };
  }

  static List<Map<String, dynamic>> _toMapList(Object? value) {
    if (value is! List) return const [];
    return value
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
