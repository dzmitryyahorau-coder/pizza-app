import 'package:flutter/material.dart';
import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/cart/mock/cart_mock_data.dart';
import 'package:pizza_app/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:pizza_app/features/cart/presentation/widgets/cart_summary.dart';
import 'package:pizza_app/features/cart/presentation/widgets/cart_upcell_items.dart';
import 'package:pizza_app/features/cart/presentation/widgets/enter_delivery_address.dart';
import 'package:pizza_app/features/cart/presentation/widgets/cart_header.dart';
import 'package:pizza_app/shared/widgets/custom_text_field.dart';
import 'package:pizza_app/shared/widgets/primary_filled_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(CartMockData.cartItems);
  }

  void _increment(int index) {
    setState(() {
      final item = _items[index];
      _items[index] = item.copyWith(quantity: item.quantity + 1);
    });
  }

  void _decrement(int index) {
    setState(() {
      final item = _items[index];
      if (item.quantity > 1) {
        _items[index] = item.copyWith(quantity: item.quantity - 1);
      } else {
        _items.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsGeometry.only(bottom: AppSpacing.l),
                child: CartHeader(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: AppSpacing.m),
                child: EnterDeliveryAddress(),
              ),
            ),
            SliverList.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return CartItemTile(
                  item: _items[index],
                  onIncrement: () => _increment(index),
                  onDecrement: () => _decrement(index),
                );
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  left: AppSpacing.xl,
                  top: AppSpacing.xl,
                ),
                child: CartUpcellItems(),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3 * AppSpacing.xl,
                  vertical: 2 * AppSpacing.l,
                ),
                child: SizedBox(
                  height: 52,
                  child: CustomTextField(
                    hintText: l10n.enterPromoCodePlaceholder,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: CartSummary(
                itemsCount: _items.length,
                totalPrice: 500,
                dodocoins: 140,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: ColoredBox(
            color: Colors.black,
            child: SizedBox(
              height: 56,
              child: PrimaryFilledButton(
                onPressed: () {},
                label: l10n.proceedToCheckoutForButton(500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
