import 'package:pizza_app/core/di/locator.dart';
import 'package:pizza_app/features/menu/bloc/menu_bloc.dart';
import 'package:pizza_app/features/menu/data/repositories/categories/inmemory_categories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/categories/supabase_categories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/products/inmemory_products_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/products/supabase_products_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/stories/inmemory_stories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/stories/supabase_stories_repository.dart';
import 'package:pizza_app/features/menu/domain/repositories/categories/categories_repository_interface.dart';
import 'package:pizza_app/features/menu/domain/repositories/products/products_repository_interface.dart';
import 'package:pizza_app/features/menu/domain/repositories/stories/stories_repository_interface.dart';

void registerMenu(bool isDev) {
  if (isDev) {
    sl.registerLazySingleton<IProductsRepository>(
      () => InmemoryProductsRepository(),
    );
    sl.registerLazySingleton<ICategoriesRepository>(
      () => InmemoryCategoriesRepository(),
    );
    sl.registerLazySingleton<IStoriesRepository>(
      () => InmemoryStoriesRepository(),
    );
  } else {
    sl.registerLazySingleton<IProductsRepository>(
      () => SupabaseProductsRepository(),
    );
    sl.registerLazySingleton<ICategoriesRepository>(
      () => SupabaseCategoriesRepository(),
    );
    sl.registerLazySingleton<IStoriesRepository>(
      () => SupabaseStoriesRepository(),
    );
  }

  sl.registerFactory<MenuBloc>(
    () => MenuBloc(
      products: sl<IProductsRepository>(),
      categories: sl<ICategoriesRepository>(),
      stories: sl<IStoriesRepository>(),
    ),
  );
}
