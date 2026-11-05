import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/features/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/product_details/bloc/product_details_cubit.dart';
import 'package:pizza_app/features/product_details/bloc/product_details_state.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/customize_mode_view.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/default_mode/default_mode_view.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        switch (state) {
          case ProductDetailsLoading():
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case ProductDetailsFailure():
            return Scaffold(
              appBar: AppBar(
                leading: BackButton(onPressed: () => context.pop()),
              ),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    Text('This product cannot be customized'),

                    /// temporary filling, will be another screen (maybe :))
                    FilledButton(onPressed: () {}, child: const Text('Retry')),
                  ],
                ),
              ),
            );
          case ProductDetailsLoaded():
            return _ProductDetailsView(state: state);
        }
      },
    );
  }
}

class _ProductDetailsView extends StatefulWidget {
  const _ProductDetailsView({required this._state});

  final ProductDetailsLoaded _state;

  @override
  State<_ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<_ProductDetailsView> {
  bool _isCustomizeMode = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleCustomizationMode() {
    setState(() => _isCustomizeMode = !_isCustomizeMode);
  }

  void _addProductToCart(ProductDetailsLoaded state) {
    final selectedToppings = jsonEncode(
      state.draft.toppingIds
          .map((id) => state.product.mapToppingsById[id]?.toMap())
          .toList(),
    );

    final removedIngredientsJson = jsonEncode(
      state.draft.toppingIds
          .map((id) => state.product.mapIngredientById[id]?.toMap())
          .toList(),
    );

    final newItemToCart = CartItem(
      id: 0,
      productId: state.product.id,
      name: state.product.name,
      imageAsset: state.product.imageAsset,
      price: state.unitPrice,
      quantity: 1,
      selectedToppingsJson: selectedToppings,
      removedIngredientsJson: removedIngredientsJson,
      sizeName: context.l10n.productSizeCm(state.selectedSize.cm),
      doughName: state.selectedDough.name,
    );

    context.read<CartCubit>().addToCart(newItemToCart);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final (draft, product) = (widget._state.draft, widget._state.product);
    final state = widget._state;

    final body = _isCustomizeMode
        ? CustomizeModeView(
            title: product.name,
            size: state.selectedSize,
            toppings: product.toppings,
            ingredients: product.ingredients,
            selectedDough: state.selectedDough,
            doughs: product.doughs,
            price: state.unitPrice,
            selectedToppingIds: state.draft.toppingIds,
            removedIngredientIds: state.draft.removedIngredientIds,
            onSelectDoughType: (d) =>
                context.read<ProductDetailsCubit>().selectDough(d.id),
            onSelectTopping: (t) =>
                context.read<ProductDetailsCubit>().toggleTopping(t.id),
            onTapIngredient: (i) => context.read<ProductDetailsCubit>().toggleIngredient(i.id),
            onCloseView: _toggleCustomizationMode,
            onPressAddToCart: () => _addProductToCart(state),
          )
        : DefaultModeView(
            title: product.name,
            description: product.description,
            sizes: product.sizes,
            selectedSize: state.selectedSize,
            price: state.unitPrice,
            onSelectedSize: (s) =>
                context.read<ProductDetailsCubit>().selectSize(s.id),
            onPressCustomizationButton: _toggleCustomizationMode,
            onClose: () => context.pop(),
            onPressAddToCart: () => _addProductToCart(state),
          );

    return Scaffold(body: body);
  }
}
