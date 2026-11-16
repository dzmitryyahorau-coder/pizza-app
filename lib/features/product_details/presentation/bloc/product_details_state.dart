import 'package:equatable/equatable.dart';
import 'package:pizza_app/features/product_details/data/models/dough.dart';
import 'package:pizza_app/features/product_details/data/models/product_details.dart';
import 'package:pizza_app/features/product_details/data/models/product_size.dart';
import 'package:pizza_app/features/product_details/domain/cart_item_draft.dart';
import 'package:pizza_app/features/product_details/domain/price_calculator.dart';

enum ProductDetailsError { notFound, notCustomizable, network }

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];
}

final class ProductDetailsLoading extends ProductDetailsState {
  const ProductDetailsLoading();
}

final class ProductDetailsFailure extends ProductDetailsState {
  final ProductDetailsError error;

  const ProductDetailsFailure(this.error);

  @override
  List<Object?> get props => [error];
}

final class ProductDetailsLoaded extends ProductDetailsState {
  const ProductDetailsLoaded({required this.product, required this.draft});

  final ProductDetails product;
  final CartItemDraft draft;

  ProductSize get selectedSize =>
      product.sizes.firstWhere((s) => s.id == draft.sizeId);
  Dough get selectedDough =>
      product.doughs.firstWhere((d) => d.id == draft.doughId);
  int get unitPrice => calculateUnitPrice(product, draft);

  ProductDetailsLoaded copyWith({CartItemDraft? draft}) =>
      ProductDetailsLoaded(product: product, draft: draft ?? this.draft);

  @override
  List<Object?> get props => [product, draft];
}
