import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/core/navigation/app_router.dart';
import 'package:pizza_app/core/theme/theme_cubit.dart';
import 'package:pizza_app/features/cart/service_locator.dart';
import 'package:pizza_app/features/delivery/register_services.dart';
import 'package:pizza_app/features/menu/register_services.dart';
import 'package:pizza_app/features/order/register_services.dart';
import 'package:pizza_app/features/product_details/register_services.dart';
import 'package:pizza_app/features/profile/register_services.dart';
import 'package:pizza_app/shared/auth/bloc/auth_cubit.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:pizza_app/shared/auth/register_services.dart';
import 'package:pizza_app/shared/service/analytics_service.dart';
import 'package:pizza_app/shared/service/battery_service.dart';
import 'package:pizza_app/shared/service/permission_handler.dart';
import 'package:pizza_app/shared/service/push_notifications_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initLocator(String environment) async {
  final isDev = environment == 'dev';
  final prefs = await SharedPreferences.getInstance();

  sl.registerSingleton<ThemeCubit>(ThemeCubit(prefs));
  sl.registerSingleton<CurrentUserStore>(CurrentUserStore());
  sl.registerSingleton<PermissionHandler>(PermissionHandler());
  sl.registerSingleton<BatteryService>(BatteryService());

  sl.registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  sl.registerLazySingleton<AppRouter>(() => AppRouter(sl<AuthCubit>()));

  if (!isDev) _registerExternalServices();

  registerAuth();
  registerProfile();
  registerMenu(isDev);
  registerProductDetails(isDev);
  registerCart(isDev);
  registerDelivery();
  registerOrder();
}

void _registerExternalServices() {
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());
  sl.registerLazySingleton<PushNotificationService>(
    () => PushNotificationService(),
  );
}
