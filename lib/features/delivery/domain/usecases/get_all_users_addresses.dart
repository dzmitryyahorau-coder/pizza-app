import 'package:pizza_app/core/domain/usecase.dart';
import 'package:pizza_app/features/delivery/data/models/address.dart';
import 'package:pizza_app/features/delivery/data/repositories/address_repository.dart';

class GetAllUserAddressesUsecase extends Usecase<List<Address>, String> {
  final IAddressRepository _addressRepository;

  GetAllUserAddressesUsecase(this._addressRepository);

  @override
  Future<List<Address>> call(String userId) {
    return _addressRepository.getUserAddresses(userId);
  }
}
