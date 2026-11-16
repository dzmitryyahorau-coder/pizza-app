import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:pizza_app/features/delivery/data/models/address_model.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_state.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';

class AddressesCubit extends Cubit<AddressesState> {
  final CurrentUserStore _currentUserStore;

  late final _geocoding = Geocoding();

  AddressesCubit({required this._currentUserStore})
    : super(const AddressesState());

  Future<Address?> locateAddress() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final placemarks = await _geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isEmpty) return null;

      final p = placemarks.first;
      final street = p.thoroughfare ?? '';
      if (street.isEmpty) return null;

      return Address(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        userId: _currentUserStore.value!.id,
        label: AddressLabel.other,
        city: p.locality ?? '',
        street: street,
        house: p.subThoroughfare ?? '',
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      debugPrint('locateAddress failed: $e');
      return null;
    }
  }

  Future<void> loadUserLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return;

      final last = await Geolocator.getLastKnownPosition();
      if (last != null) {
        emit(
          state.copyWith(userLocation: LatLng(last.latitude, last.longitude)),
        );
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
      emit(state.copyWith(userLocation: LatLng(pos.latitude, pos.longitude)));
    } catch (e) {
      debugPrint('loadUserLocation failed: $e');
    }
  }

  void addAndSelect(Address draft) {
    emit(
      state.copyWith(
        addresses: [...state.addresses, draft],
        selectedId: draft.id,
      ),
    );
  }

  void selectAddress(String id) {
    emit(state.copyWith(selectedId: id));
  }
}
