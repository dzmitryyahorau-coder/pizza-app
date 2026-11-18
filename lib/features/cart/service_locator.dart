import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/core/di/locator.dart';
import 'package:pizza_app/features/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/cart/data/repositories/cart_repository_interface.dart';
import 'package:pizza_app/features/cart/data/repositories/drift_cart_depository.dart';
import 'package:pizza_app/features/cart/data/repositories/inmemory_cart_repository.dart';

void registerCart(bool isDev) {
  sl.registerLazySingleton<ICartRepository>(
    () => isDev
        ? InmemoryCartRepository()
        : DriftCartRepository(sl<AppDatabase>()),
  );

  sl.registerLazySingleton<CartCubit>(() => CartCubit(sl<ICartRepository>()));
}
