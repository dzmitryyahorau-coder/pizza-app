import 'package:equatable/equatable.dart';
import 'package:pizza_app/features/product_details/data/models/product_details.dart';

class CartItemDraft extends Equatable {
  final String sizeId;
  final String doughId;
  final Set<String> toppingIds;
  final Set<String> removedIngredientIds;

  const CartItemDraft({
    required this.sizeId,
    required this.doughId,
    this.toppingIds = const {},
    this.removedIngredientIds = const {},
  });

  factory CartItemDraft.initial(ProductDetails product) {
    return CartItemDraft(
      sizeId: product.sizes
          .firstWhere(
            (s) => s.id == product.defaultSizeId,
            orElse: () => product.sizes.first,
          )
          .id,
      doughId: product.doughs
          .firstWhere(
            (s) => s.id == product.defaultDoughId,
            orElse: () => product.doughs.first,
          )
          .id,
    );
  }

  CartItemDraft copyWith({
    String? sizeId,
    String? doughId,
    Set<String>? toppingIds,
    Set<String>? removedIngredientIds,
  }) => CartItemDraft(
    sizeId: sizeId ?? this.sizeId,
    doughId: doughId ?? this.doughId,
    toppingIds: toppingIds ?? this.toppingIds,
    removedIngredientIds: removedIngredientIds ?? this.removedIngredientIds,
  );

  @override
  List<Object?> get props => [
    sizeId,
    doughId,
    toppingIds,
    removedIngredientIds,
  ];
}
