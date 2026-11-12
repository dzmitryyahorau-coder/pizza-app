import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/core/di/locator.dart';
import 'package:pizza_app/core/navigation/app_router.dart';
import 'package:pizza_app/core/theme/app_theme.dart';
import 'package:pizza_app/features/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/firebase_options.dart';
import 'package:pizza_app/shared/auth/bloc/auth_cubit.dart';
import 'package:pizza_app/shared/auth/bloc/auth_state.dart';
import 'package:pizza_app/shared/service/fcm_background_handler.dart';
import 'package:pizza_app/shared/service/push_notifications_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const env = String.fromEnvironment('ENV', defaultValue: 'prod');

  await dotenv.load();

  if (env == 'prod') {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      publishableKey: dotenv.env['SUPABASE_PUBLISHABLE_KEY'],
      debug: true,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  await initLocator(env);

  runApp(const MainApp());
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
