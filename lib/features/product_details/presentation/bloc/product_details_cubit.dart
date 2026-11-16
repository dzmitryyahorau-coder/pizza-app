import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details/product_details_repository_interface.dart';
import 'package:pizza_app/features/product_details/domain/cart_item_draft.dart';
import 'package:pizza_app/shared/service/analytics_service.dart';

import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this._repository, this._analyticsService)
    : super(const ProductDetailsLoading());

  final IProductDetailsRepository _repository;
  final AnalyticsService _analyticsService;

  Future<void> load(String productId) async {
    emit(const ProductDetailsLoading());
    try {
      final product = await _repository.getProductDetails(productId);
      if (isClosed) return;

      if (product == null) {
        emit(const ProductDetailsFailure(ProductDetailsError.notFound));
      } else if (product.sizes.isEmpty || product.doughs.isEmpty) {
        emit(const ProductDetailsFailure(ProductDetailsError.notCustomizable));
      } else {
        final draft = CartItemDraft.initial(product);
        emit(ProductDetailsLoaded(product: product, draft: draft));

        await _analyticsService.logViewItem(
          id: product.id,
          name: product.name,
          category: product.category?.name ?? 'unknown',
          price: 0, //state is ProductDetailsLoaded ? (state as ProductDetailsLoaded)?.unitPrice : 0,
        );
      }
    } catch (e, stackTrace) {
      addError(e, stackTrace);
      if (isClosed) return;
      emit(const ProductDetailsFailure(ProductDetailsError.network));
    }
  }

  void selectSize(String sizeId) =>
      _updateDraft((d) => d.copyWith(sizeId: sizeId));

  void selectDough(String doughId) =>
      _updateDraft((d) => d.copyWith(doughId: doughId));

  void toggleTopping(String toppingId) {
    _updateDraft((draft) {
      final toppingIds = {...draft.toppingIds};

      if (toppingIds.contains(toppingId)) {
        toppingIds.remove(toppingId);
      } else {
        toppingIds.add(toppingId);
      }

      return draft.copyWith(toppingIds: toppingIds);
    });
  }

  void toggleIngredient(String ingredientId) {
    _updateDraft((draft) {
      final removedIngredientIds = {...draft.removedIngredientIds};

      if (removedIngredientIds.contains(ingredientId)) {
        removedIngredientIds.remove(ingredientId);
      } else {
        removedIngredientIds.add(ingredientId);
      }

      return draft.copyWith(removedIngredientIds: removedIngredientIds);
    });
  }

  void _updateDraft(CartItemDraft Function(CartItemDraft) update) {
    final current = state;
    if (current is! ProductDetailsLoaded) return;
    emit(current.copyWith(draft: update(current.draft)));
  }
}
