import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:pizza_app/features/delivery/data/models/address_model.dart';

class AddressesState extends Equatable {
  const AddressesState({
    this.addresses = const [],
    this.selectedId,
    this.pendingAddress,
    this.userLocation,
  });

  final List<Address> addresses;
  final String? selectedId;
  final Address? pendingAddress;
  final LatLng? userLocation;

  Address? get selectedAddress {
    if (selectedId == null) return null;

    final found = addresses.firstWhere((a) => a.id == selectedId);

    return found;
  }

  bool get canOrder => selectedId != null;

  AddressesState copyWith({
    List<Address>? addresses,
    String? selectedId,
    Address? pendingAddress,
    LatLng? userLocation,
  }) {
    return AddressesState(
      addresses: addresses ?? this.addresses,
      selectedId: selectedId ?? this.selectedId,
      pendingAddress: pendingAddress ?? this.pendingAddress,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  @override
  List<Object?> get props => [
    addresses,
    selectedId,
    pendingAddress,
    userLocation,
  ];
}
