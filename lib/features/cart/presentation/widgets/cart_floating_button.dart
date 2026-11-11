import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/features/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/cart/bloc/cart_state.dart';

class CartFloatingButton extends StatelessWidget {
  const CartFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.items.isEmpty) {
          return const SizedBox.shrink();
        }
        final totalPrice = state.items.fold<int>(
          0,
          (sum, item) => sum + (item.price * item.quantity),
        );

        return FloatingActionButton.extended(
          onPressed: () {
            context.push('/cart');
          },
          backgroundColor: context.appColors.brandColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          icon: const Icon(Icons.shopping_cart_outlined, size: 20),
          label: Text(
            l10n.productPrice(totalPrice),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
