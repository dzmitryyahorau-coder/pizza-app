import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:pizza_app/features/delivery/data/models/address.dart';
import 'package:pizza_app/features/delivery/domain/usecases/add_new_user_address_usecase.dart';
import 'package:pizza_app/features/delivery/domain/usecases/get_all_users_addresses.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_state.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';

class AddressesCubit extends Cubit<AddressesState> {
  final CurrentUserStore _currentUserStore;
  final AddNewUserAddressUsecase _addNewAddress;
  final GetAllUserAddressesUsecase _getAllUserAddressesUsecase;

  late final _geocoding = Geocoding();

  AddressesCubit({
    required this._currentUserStore,
    required this._addNewAddress,
    required this._getAllUserAddressesUsecase,
  }) : super(const AddressesState());

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

  Future<bool> addAddress(Address draft) async {
    try {
      final userId = _currentUserStore.value!.id;
      final saved = await _addNewAddress(
        AddNewUserAddressParams(data: draft, userId: userId),
      );
      emit(
        state.copyWith(
          addresses: [...state.addresses, saved],
          selectedId: saved.id,
        ),
      );
      return true;
    } catch (e) {
      debugPrint('addAddress failed: $e');
      return false;
    }
  }

  Future<void> fetchUserAddresses() async {
    try {
      final userId = _currentUserStore.value!.id;
      final userAddresses = await _getAllUserAddressesUsecase(userId);
      emit(state.copyWith(addresses: userAddresses));
    } catch (e) {
      debugPrint('fetchUserAddresses failed: $e');
    }
  }

  void selectAddress(String id) {
    emit(state.copyWith(selectedId: id));
  }
}
