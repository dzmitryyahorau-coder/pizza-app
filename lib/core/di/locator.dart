import 'package:get_it/get_it.dart';
import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/core/navigation/app_router.dart';
import 'package:pizza_app/features/cart/data/repositories/drift_cart_depository.dart';
import 'package:pizza_app/features/cart/data/repositories/inmemory_cart_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/categories/categories_repository_interface.dart';
import 'package:pizza_app/features/menu/data/repositories/categories/firestore_categories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/categories/inmemory_categories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/products/firestore_products_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/products/inmemory_products_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/products/products_repository_interface.dart';
import 'package:pizza_app/features/menu/data/repositories/stories/firestore_stories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/stories/inmemory_stories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/stories/stories_repository_interface.dart';
import 'package:pizza_app/features/product_details/bloc/product_details_cubit.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/firestore_product_details_repository.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/inmemory_product_details_repository.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/product_details_repository_interface.dart';
import 'package:pizza_app/shared/auth/bloc/auth_cubit.dart';

import 'package:pizza_app/features/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/cart/data/repositories/cart_repository_interface.dart';
import 'package:pizza_app/features/menu/bloc/menu_bloc.dart';

final sl = GetIt.instance;

Future<void> initLocator(String environment) async {
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit());
  sl.registerLazySingleton<CartCubit>(() => CartCubit(sl<ICartRepository>()));

  sl.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(sl<IProductDetailsRepository>()),
  );
  sl.registerFactory<MenuBloc>(
    () => MenuBloc(
      products: sl<IProductsRepository>(),
      categories: sl<ICategoriesRepository>(),
      stories: sl<IStoriesRepository>(),
    ),
  );

  sl.registerLazySingleton<AppRouter>(() => AppRouter(sl<AuthCubit>()));

  // --- РАЗДЕЛЕНИЕ ПО ОКРУЖЕНИЯМ (FLAVORS) ---
  if (environment == 'dev') {
    // DEV окружение: подставляем in-memory репозитории
    sl.registerLazySingleton<IProductsRepository>(
      () => InmemoryProductsRepository(),
    );
    sl.registerLazySingleton<ICategoriesRepository>(
      () => InmemoryCategoriesRepository(),
    );
    sl.registerLazySingleton<IStoriesRepository>(
      () => InmemoryStoriesRepository(),
    );
    sl.registerLazySingleton<IProductDetailsRepository>(
      () => InmemoryProductDetailsRepository(),
    );
    sl.registerLazySingleton<ICartRepository>(() => InmemoryCartRepository());
  } else {
    sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

    sl.registerLazySingleton<IProductsRepository>(
      () => FirestoreProductsRepository(),
    );
    sl.registerLazySingleton<ICategoriesRepository>(
      () => FirestoreCategoriesRepository(),
    );
    sl.registerLazySingleton<IStoriesRepository>(
      () => FirestoreStoriesRepository(),
    );
    sl.registerLazySingleton<IProductDetailsRepository>(
      () => FirestoreProductDetailsRepository(),
    );
    sl.registerLazySingleton<ICartRepository>(
      () => DriftCartRepository(sl<AppDatabase>()),
    );
  }
}
