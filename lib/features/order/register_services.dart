import 'package:pizza_app/core/di/locator.dart';
import 'package:pizza_app/features/order/data/repositories/supabase_order_repository.dart';
import 'package:pizza_app/features/order/domain/repositories/order_repository_interface.dart';
import 'package:pizza_app/features/order/domain/usecases/create_order_usecase.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void registerOrder() {
  sl.registerLazySingleton<IOrderRepository>(
    () => SupabaseOrderRepository(sl<SupabaseClient>()),
  );

  sl.registerFactory<CreateOrderUsecase>(
    () => CreateOrderUsecase(
      orderRepository: sl<IOrderRepository>(),
      currentUserStore: sl<CurrentUserStore>(),
    ),
  );
}
