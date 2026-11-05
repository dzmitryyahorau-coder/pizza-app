import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/navigation/cubit_refresh_listenable.dart';
import 'package:pizza_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:pizza_app/features/menu/bloc/menu_bloc.dart';
import 'package:pizza_app/features/menu/bloc/menu_event.dart';
import 'package:pizza_app/features/menu/data/repositories/categories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/product_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/stories_repository.dart';
import 'package:pizza_app/features/menu/presentation/screens/menu_screen.dart';
import 'package:pizza_app/features/product_details/bloc/product_details_cubit.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details_repository.dart';
import 'package:pizza_app/features/product_details/presentation/screens/product_details_screen.dart';
import 'package:pizza_app/features/profile/screens/login_screen.dart';
import 'package:pizza_app/shared/auth/bloc/auth_cubit.dart';
import 'package:pizza_app/shared/auth/bloc/auth_state.dart';

class AppRouter {
  final AuthCubit authCubit;

  AppRouter(this.authCubit);

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: CubitRefreshListenable<AuthCubit, AuthState>(authCubit),
    redirect: (context, state) {
      final authState = authCubit.state;
      final isLoggingIn = state.matchedLocation == '/login';
      final isLoggedIn = authState is Authenticated;

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/';
      return null;
    },
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
            builder: (BuildContext context, GoRouterState state) =>
                BlocProvider(
                  create: (context) => ProductDetailsCubit(
                    context.read<IProductDetailsRepository>(),
                  )..load(state.pathParameters['id']!),
                  child: ProductDetailsScreen(
                    productId: state.pathParameters['id']!,
                  ),
                ),
          ),
        ],
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    ],
  );
}
