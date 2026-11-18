import 'package:pizza_app/core/domain/usecase.dart';
import 'package:pizza_app/features/delivery/data/models/address.dart';
import 'package:pizza_app/features/delivery/data/repositories/address_repository.dart';

class AddNewUserAddressParams {
  final Address data;
  final String userId;

  AddNewUserAddressParams({required this.data, required this.userId});
}

class AddNewUserAddressUsecase
    extends Usecase<Address, AddNewUserAddressParams> {
  final IAddressRepository _addressRepository;

  AddNewUserAddressUsecase(this._addressRepository);

  @override
  Future<Address> call(AddNewUserAddressParams params) async {
    return await _addressRepository.addAddress(params.userId, params.data);
  }
}
