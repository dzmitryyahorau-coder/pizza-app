import 'order_item.dart';
import 'order_status.dart';

class Order {
  const Order({
    this.id,
    required this.userId,
    this.status = OrderStatus.processing,
    required this.totalPrice,
    this.addressId,
    required this.city,
    required this.street,
    required this.house,
    this.entrance,
    this.intercom,
    this.floor,
    this.apartment,
    this.courierComment,
    required this.latitude,
    required this.longitude,
    this.createdAt,
    this.items = const [],
  });

  final String? id;
  final String userId;
  final OrderStatus status;
  final int totalPrice;

  final String? addressId;
  final String city;
  final String street;
  final String house;
  final String? entrance;
  final String? intercom;
  final String? floor;
  final String? apartment;
  final String? courierComment;
  final double latitude;
  final double longitude;

  final DateTime? createdAt;
  final List<OrderItem> items;

  String get fullAddress => '$city, $street, $house';

  factory Order.fromMap(Map<String, dynamic> map) {
    final rawItems = map['order_item'] as List? ?? const [];

    return Order(
      id: map['id'] as String?,
      userId: map['user_id'] as String,
      status: OrderStatus.fromString(map['status'] as String?),
      totalPrice: (map['total_price'] as num).toInt(),
      addressId: map['address_id'] as String?,
      city: map['city'] as String,
      street: map['street'] as String,
      house: map['house'] as String,
      entrance: map['entrance'] as String?,
      intercom: map['intercom'] as String?,
      floor: map['floor'] as String?,
      apartment: map['apartment'] as String?,
      courierComment: map['courier_comment'] as String?,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      createdAt: map['created_at'] == null
          ? null
          : DateTime.parse(map['created_at'] as String),
      items: rawItems
          .map((e) => OrderItem.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'status': status.name,
      'total_price': totalPrice,
      if (addressId != null) 'address_id': addressId,
      'city': city,
      'street': street,
      'house': house,
      'entrance': entrance,
      'intercom': intercom,
      'floor': floor,
      'apartment': apartment,
      'courier_comment': courierComment,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
