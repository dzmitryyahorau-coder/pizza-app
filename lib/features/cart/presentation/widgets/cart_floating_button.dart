import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';

class CartFloatingButton extends StatelessWidget {
  final AppDatabase database;

  const CartFloatingButton({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return StreamBuilder<List<CartItem>>(
      stream: database.watchCartItems(),
      builder: (context, snapshot) {
        final items = snapshot.data ?? [];

        if (items.isEmpty) {
          return const SizedBox.shrink();
        }
        final totalPrice = items.fold<int>(
          0,
          (sum, item) => sum + (item.price * item.quantity),
        );

        return FloatingActionButton.extended(
          onPressed: () {
            context.go('/cart');
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
