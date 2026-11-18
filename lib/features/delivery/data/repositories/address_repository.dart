import 'package:pizza_app/features/delivery/data/models/address.dart';

abstract interface class IAddressRepository {
  Future<Address> addAddress(String userId, Address address);
  Future<List<Address>> getUserAddresses(String userId);
  Future<Address> getAddressById(String id);
}
