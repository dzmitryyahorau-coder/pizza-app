import 'package:equatable/equatable.dart';

enum AddressLabel {
  home,
  work,
  other;

  static AddressLabel fromString(String? value) {
    return AddressLabel.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AddressLabel.other,
    );
  }
}

class Address extends Equatable {
  const Address({
    this.id,
    required this.userId,
    required this.label,
    required this.city,
    required this.street,
    required this.house,
    required this.latitude,
    required this.longitude,
    this.entrance,
    this.intercom,
    this.floor,
    this.apartment,
    this.courierComment,
  });

  final String? id;
  final String userId;
  final AddressLabel label;
  final String city;
  final String street;
  final String house;
  final double latitude;
  final double longitude;
  final String? entrance;
  final String? intercom;
  final String? floor;
  final String? apartment;
  final String? courierComment;

  String get fullAddress => '$city, $street, $house';

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      label: AddressLabel.fromString(map['label'] as String?),
      city: map['city'] as String,
      street: map['street'] as String,
      house: map['house'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      entrance: map['entrance'] as String?,
      intercom: map['intercom'] as String?,
      floor: map['floor'] as String?,
      apartment: map['apartment'] as String?,
      courierComment: map['courier_comment'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'label': label.name,
      'city': city,
      'street': street,
      'house': house,
      'latitude': latitude,
      'longitude': longitude,
      'entrance': entrance,
      'intercom': intercom,
      'floor': floor,
      'apartment': apartment,
      'courier_comment': courierComment,
    };
  }

  @override
  List<Object?> get props => [
    userId,
    label,
    city,
    street,
    house,
    latitude,
    longitude,
    entrance,
    intercom,
    floor,
    apartment,
    courierComment,
  ];
}
