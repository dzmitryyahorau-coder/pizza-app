import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizza_app/core/di/locator.dart';
import 'package:pizza_app/features/profile/data/repositories/firebase_auth_repository.dart';
import 'package:pizza_app/features/profile/data/repositories/supabase_user_repository.dart';
import 'package:pizza_app/features/profile/domain/repositories/auth_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/repositories/user_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/usecases/logout_usecase.dart';
import 'package:pizza_app/features/profile/domain/usecases/sign_in_usecase.dart';
import 'package:pizza_app/features/profile/domain/usecases/sign_up_usecase.dart';
import 'package:pizza_app/shared/auth/bloc/auth_cubit.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void registerAuth() {
  sl.registerLazySingleton<IAuthRepository>(
    () => FirebaseAuthRepository(sl<FirebaseAuth>()),
  );
  sl.registerLazySingleton<IUserRepository>(
    () => SupabaseUserRepository(sl<SupabaseClient>()),
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

  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      signUpUsecase: sl<SignUpUsecase>(),
      signInUsecase: sl<SignInUsecase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      currentUserStore: sl<CurrentUserStore>(),
    ),
  );
}
