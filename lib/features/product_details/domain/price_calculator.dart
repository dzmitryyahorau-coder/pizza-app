import 'package:pizza_app/features/product_details/data/models/product_details.dart';
import 'package:pizza_app/features/product_details/domain/cart_item_draft.dart';

int calculateUnitPrice(ProductDetails product, CartItemDraft draft) {
  final size = product.sizes.firstWhere((s) => s.id == draft.sizeId);
  final dough = product.doughs.firstWhere((d) => d.id == draft.doughId);
  final toppingsSum = product.toppings
      .where((t) => draft.toppingIds.contains(t.id))
      .fold<int>(0, (sum, item) => sum + item.price);

  return size.price + dough.extraPrice + toppingsSum;
}
