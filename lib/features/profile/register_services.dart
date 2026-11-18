import 'package:pizza_app/core/di/locator.dart';
import 'package:pizza_app/features/profile/data/repositories/supabase_storage_repository.dart';
import 'package:pizza_app/features/profile/domain/repositories/auth_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/repositories/storage_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/repositories/user_repository_interface.dart';
import 'package:pizza_app/features/profile/domain/usecases/update_avatar_usecase.dart';
import 'package:pizza_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:pizza_app/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void registerProfile() {
  sl.registerLazySingleton<IStorageRepository>(
    () => SupabaseStorageRepository(sl<SupabaseClient>()),
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

  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      updateAvatarUsecase: sl<UpdateAvatarUsecase>(),
      updateProfileUsecase: sl<UpdateProfileUsecase>(),
      currentUserStore: sl<CurrentUserStore>(),
    ),
  );
}
