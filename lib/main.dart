import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/core/navigation/app_router.dart';
import 'package:pizza_app/core/theme/app_theme.dart';
import 'package:pizza_app/features/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/cart/data/repositories/cart_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/categories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/product_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/stories_repository.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details_repository.dart';
import 'package:pizza_app/firebase_options.dart';
import 'package:pizza_app/shared/auth/bloc/auth_cubit.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthCubit _authCubit;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authCubit = AuthCubit();
    _appRouter = AppRouter(_authCubit);
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IProductsRepository>(
          create: (_) => FirestoreProductsRepository(),
        ),
        RepositoryProvider<ICategoriesRepository>(
          create: (_) => FirestoreCategoriesRepository(),
        ),
        RepositoryProvider<IStoriesRepository>(
          create: (_) => FirestoreStoriesRepository(),
        ),
        RepositoryProvider<ICartRepository>(
          create: (_) => DriftCartRepository(AppDatabase()),
        ),
        RepositoryProvider<IProductDetailsRepository>(
          create: (_) => FirestoreProductDetailsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>.value(value: _authCubit),
          BlocProvider<CartCubit>(
            create: (context) => CartCubit(context.read<ICartRepository>()),
          ),
        ],
        child: MaterialApp.router(
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          routerConfig: _appRouter.router,
        ),
      ),
    );
  }
}
