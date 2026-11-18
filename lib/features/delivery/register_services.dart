import 'package:pizza_app/core/di/locator.dart';
import 'package:pizza_app/features/delivery/data/repositories/address_repository.dart';
import 'package:pizza_app/features/delivery/domain/repositories/supabase_address_repository.dart';
import 'package:pizza_app/features/delivery/domain/usecases/add_new_user_address_usecase.dart';
import 'package:pizza_app/features/delivery/domain/usecases/get_all_users_addresses.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_cubit.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void registerDelivery() {
  sl.registerLazySingleton<IAddressRepository>(
    () => SupabaseAddressRepository(sl<SupabaseClient>()),
  );

  sl.registerFactory<AddNewUserAddressUsecase>(
    () => AddNewUserAddressUsecase(sl<IAddressRepository>()),
  );
  sl.registerFactory<GetAllUserAddressesUsecase>(
    () => GetAllUserAddressesUsecase(sl<IAddressRepository>()),
  );

  sl.registerFactory<AddressesCubit>(
    () => AddressesCubit(
      currentUserStore: sl<CurrentUserStore>(),
      addNewAddress: sl<AddNewUserAddressUsecase>(),
      getAllUserAddressesUsecase: sl<GetAllUserAddressesUsecase>(),
    ),
  );
}
