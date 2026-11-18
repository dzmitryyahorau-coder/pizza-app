import 'package:pizza_app/core/di/locator.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/inmemory_product_details_repository.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/product_details_repository_interface.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/supabase_product_details_repository.dart';
import 'package:pizza_app/features/product_details/presentation/bloc/product_details_cubit.dart';
import 'package:pizza_app/shared/service/analytics_service.dart';

void registerProductDetails(bool isDev) {
  sl.registerLazySingleton<IProductDetailsRepository>(
    () => isDev
        ? InmemoryProductDetailsRepository()
        : SupabaseProductDetailsRepository(),
  );

  sl.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(
      sl<IProductDetailsRepository>(),
      sl<AnalyticsService>(),
    ),
  );
}
