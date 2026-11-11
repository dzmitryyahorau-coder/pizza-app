import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/cart/bloc/cart_state.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final items = state.items;
        final totalPrice = state.totalPrice;

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(bottom: AppSpacing.l),
                    child: CartHeader(
                      onClearCart: () {
                        context.read<CartCubit>().clearCart();
                      },
                      onClose: () {
                        context.pop();
                      },
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: AppSpacing.m,
                    ),
                    child: EnterDeliveryAddress(),
                  ),
                ),

                SliverList.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CartItemTile(
                      item: item,
                      onIncrement: () {
                        context.read<CartCubit>().updateQuantity(
                          item.id,
                          item.quantity + 1,
                        );
                      },
                      onDecrement: () {
                        context.read<CartCubit>().updateQuantity(
                          item.id,
                          item.quantity - 1,
                        );
                      },
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
                    itemsCount: items.length,
                    totalPrice: totalPrice,
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
                    label: l10n.proceedToCheckoutForButton(totalPrice),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
