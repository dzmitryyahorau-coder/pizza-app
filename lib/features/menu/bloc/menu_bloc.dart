import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/menu/bloc/menu_event.dart';
import 'package:pizza_app/features/menu/bloc/menu_state.dart';
import 'package:pizza_app/features/menu/data/models/product.dart';
import 'package:pizza_app/features/menu/data/repositories/categories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/product_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/stories_repository.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final IProductsRepository _products;
  final ICategoriesRepository _categories;
  final IStoriesRepository _stories;

  MenuBloc({
    required this._products,
    required this._categories,
    required this._stories,
  }) : super(const MenuState()) {
    on<MenuLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    MenuLoadRequested event,
    Emitter<MenuState> emit,
  ) async {
    if (state.status == MenuStatus.loading ||
        state.status == MenuStatus.refreshing) {
      return;
    }

    final hasData = state.categories.isNotEmpty;
    emit(
      state.copyWith(
        status: hasData ? MenuStatus.loading : MenuStatus.refreshing,
      ),
    );

    try {
      final (categories, products, stories) = await (
        _categories.getCategories(),
        _products.getProducts(),
        _stories.getStories(),
      ).wait;

      final grouped = <String, List<Product>>{
        for (final category in categories) category.id: [],
      };
      for (final product in products) {
        grouped[product.categoryId]?.add(product);
      }

      emit(
        MenuState(
          status: MenuStatus.success,
          categories: categories,
          stories: stories,
          productsByCategory: grouped,
        ),
      );
    } catch (e, stackTrace) {
      addError(e, stackTrace);
      emit(state.copyWith(status: MenuStatus.failure));
    }
  }
}
