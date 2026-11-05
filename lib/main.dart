import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/core/theme/app_theme.dart';
import 'package:pizza_app/features/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/cart/data/repositories/cart_repository.dart';
import 'package:pizza_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:pizza_app/features/menu/bloc/menu_bloc.dart';
import 'package:pizza_app/features/menu/bloc/menu_event.dart';
import 'package:pizza_app/features/menu/data/repositories/categories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/product_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/stories_repository.dart';
import 'package:pizza_app/features/product_details/bloc/product_details_cubit.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details_repository.dart';
import 'package:pizza_app/features/product_details/presentation/screens/product_details_screen.dart';
import 'package:pizza_app/features/menu/presentation/screens/menu_screen.dart';
import 'package:pizza_app/firebase_options.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (context) => MenuBloc(
          products: context.read<IProductsRepository>(),
          categories: context.read<ICategoriesRepository>(),
          stories: context.read<IStoriesRepository>(),
        )..add(const MenuLoadRequested()),
        child: const MenuScreen(),
      ),
      routes: [
        GoRoute(
          path: 'products/:id',
          builder: (BuildContext context, GoRouterState state) => BlocProvider(
            create: (context) =>
                ProductDetailsCubit(context.read<IProductDetailsRepository>())
                  ..load(state.pathParameters['id']!),
            child: ProductDetailsScreen(productId: state.pathParameters['id']!),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const CartScreen(),
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
      child: BlocProvider<CartCubit>(
        create: (context) => CartCubit(context.read<ICartRepository>()),
        child: MaterialApp.router(
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          routerConfig: _router,
        ),
      ),
    );
  }
}
