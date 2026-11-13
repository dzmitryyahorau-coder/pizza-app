import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/core/navigation/app_router.dart';
import 'package:pizza_app/core/theme/theme_cubit.dart';
import 'package:pizza_app/features/profile/data/repositories/firebase_auth_repository.dart';
import 'package:pizza_app/features/profile/data/repositories/supabase_storage_repository.dart';
import 'package:pizza_app/features/profile/data/repositories/supabase_user_repository.dart';
import 'package:pizza_app/features/profile/domain/repositories/auth_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/repositories/storage_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/repositories/user_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/usecases/logout_usecase.dart';
import 'package:pizza_app/features/profile/domain/usecases/sign_in_usecase.dart';
import 'package:pizza_app/features/profile/domain/usecases/sign_up_usecase.dart';
import 'package:pizza_app/features/cart/data/repositories/drift_cart_depository.dart';
import 'package:pizza_app/features/cart/data/repositories/inmemory_cart_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/categories/inmemory_categories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/categories/supabase_categories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/products/inmemory_products_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/products/supabase_products_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/stories/inmemory_stories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/stories/supabase_stories_repository.dart';
import 'package:pizza_app/features/menu/domain/repositories/categories/categories_repository_interface.dart';
import 'package:pizza_app/features/menu/domain/repositories/products/products_repository_interface.dart';
import 'package:pizza_app/features/menu/domain/repositories/stories/stories_repository_interface.dart';
import 'package:pizza_app/features/product_details/bloc/product_details_cubit.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/inmemory_product_details_repository.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/product_details_repository_interface.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/supabase_product_details_repository.dart';

import 'package:pizza_app/features/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/cart/data/repositories/cart_repository_interface.dart';
import 'package:pizza_app/features/menu/bloc/menu_bloc.dart';
import 'package:pizza_app/features/profile/domain/usecases/update_avatar_usecase.dart';
import 'package:pizza_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:pizza_app/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:pizza_app/shared/auth/bloc/auth_cubit.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:pizza_app/shared/service/battery_service.dart';
import 'package:pizza_app/shared/service/permission_handler.dart';
import 'package:pizza_app/shared/service/push_notifications_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initLocator(String environment) async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<ThemeCubit>(ThemeCubit(prefs));

  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      signUpUsecase: sl<SignUpUsecase>(),
      signInUsecase: sl<SignInUsecase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      currentUserStore: sl<CurrentUserStore>(),
    ),
  );
  sl.registerLazySingleton<CartCubit>(() => CartCubit(sl<ICartRepository>()));
  sl.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(sl<IProductDetailsRepository>()),
  );
  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      updateAvatarUsecase: sl<UpdateAvatarUsecase>(),
      updateProfileUsecase: sl<UpdateProfileUsecase>(),
      currentUserStore: sl<CurrentUserStore>(),
    ),
  );
  sl.registerFactory<MenuBloc>(
    () => MenuBloc(
      products: sl<IProductsRepository>(),
      categories: sl<ICategoriesRepository>(),
      stories: sl<IStoriesRepository>(),
    ),
  );
  sl.registerSingleton<BatteryService>(BatteryService());

  sl.registerLazySingleton<AppRouter>(() => AppRouter(sl<AuthCubit>()));

  sl.registerSingleton<CurrentUserStore>(CurrentUserStore());
  sl.registerSingleton<PermissionHandler>(PermissionHandler());

  // --- Flavors ---
  if (environment == 'dev') {
    // DEV env: use in-memory impls
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
    sl.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService(),
    );

    sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

    sl.registerLazySingleton<IStorageRepository>(
      () => SupabaseStorageRepository(sl<SupabaseClient>()),
    );

    sl.registerLazySingleton<IAuthRepository>(
      () => FirebaseAuthRepository(sl()),
    );
    sl.registerLazySingleton<IUserRepository>(
      () => SupabaseUserRepository(sl()),
    );

    sl.registerLazySingleton<IProductsRepository>(
      () => SupabaseProductsRepository(),
    );
    sl.registerLazySingleton<ICategoriesRepository>(
      () => SupabaseCategoriesRepository(),
    );
    sl.registerLazySingleton<IStoriesRepository>(
      () => SupabaseStoriesRepository(),
    );
    sl.registerLazySingleton<IProductDetailsRepository>(
      () => SupabaseProductDetailsRepository(),
    );
    sl.registerLazySingleton<ICartRepository>(
      () => DriftCartRepository(sl<AppDatabase>()),
    );

    sl.registerFactory(
      () => SignUpUsecase(
        sl<IAuthRepository>(),
        sl<IUserRepository>(),
        sl<CurrentUserStore>(),
      ),
    );
    sl.registerFactory(
      () => SignInUsecase(
        sl<IAuthRepository>(),
        sl<IUserRepository>(),
        sl<CurrentUserStore>(),
      ),
    );
    sl.registerFactory(
      () => LogoutUseCase(
        sl<IAuthRepository>(),
        sl<IUserRepository>(),
        sl<CurrentUserStore>(),
      ),
    );
    sl.registerFactory<UpdateAvatarUsecase>(
      () => UpdateAvatarUsecase(
        sl<IStorageRepository>(),
        sl<IUserRepository>(),
        sl<CurrentUserStore>(),
      ),
    );
    sl.registerFactory<UpdateProfileUsecase>(
      () => UpdateProfileUsecase(
        authRepository: sl<IAuthRepository>(),
        userRepository: sl<IUserRepository>(),
        currentUserStore: sl<CurrentUserStore>(),
      ),
    );
  }
}
