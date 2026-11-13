import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/core/di/locator.dart';
import 'package:pizza_app/core/navigation/app_router.dart';
import 'package:pizza_app/core/theme/app_theme.dart';
import 'package:pizza_app/features/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/profile/domain/repositories/user_repository_interface.dart';
import 'package:pizza_app/firebase_options.dart';
import 'package:pizza_app/shared/auth/bloc/auth_cubit.dart';
import 'package:pizza_app/shared/auth/bloc/auth_state.dart';
import 'package:pizza_app/shared/auth/current_user_store.dart';
import 'package:pizza_app/shared/service/fcm_background_handler.dart';
import 'package:pizza_app/shared/service/push_notifications_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState, User;
import 'package:pizza_app/shared/auth/models/user.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const env = String.fromEnvironment('ENV', defaultValue: 'prod');

  await dotenv.load();
  await initLocator(env);

  if (env == 'prod') {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      publishableKey: dotenv.env['SUPABASE_PUBLISHABLE_KEY'],
      debug: true,
      accessToken: () async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) return null;
        return await user.getIdToken();
      },
    );

    await _restoreUser();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } else {
    // sl<CurrentUserStore>().set(null);
  }

  runApp(const MainApp());
}

Future<void> _restoreUser() async {
  final store = sl<CurrentUserStore>();
  final fbUser = FirebaseAuth.instance.currentUser;

  if (fbUser == null) {
    store.set(null);
    return;
  }

  final fallback = User(
    id: fbUser.uid,
    name: fbUser.displayName ?? '',
    email: fbUser.email ?? '',
  );

  try {
    final repo = sl<IUserRepository>();
    final profile = await repo.getById(fbUser.uid);

    if (profile != null) {
      store.set(profile);
    } else {
      await repo.create(fallback);
      store.set(fallback);
    }
  } catch (_) {
    store.set(fallback);
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: sl<AuthCubit>()),
        BlocProvider<CartCubit>.value(value: sl<CartCubit>()),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            sl<PushNotificationService>().init();
          }
        },
        child: MaterialApp.router(
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          routerConfig: sl<AppRouter>().router,
        ),
      ),
    );
  }
}
