import 'package:flutter/material.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';

class CartSummary extends StatelessWidget {
  final int itemsCount;
  final int totalPrice;
  final int dodocoins;

  const CartSummary({
    super.key,
    required this.itemsCount,
    required this.totalPrice,
    required this.dodocoins,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = context.l10n;

    final labelStyle = TextStyle(
      color: colors.onSurfaceVariant,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    final valueStyle = TextStyle(
      color: colors.onSurface,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.positionsLabel(itemsCount), style: labelStyle),
              Text(l10n.productPrice(totalPrice), style: valueStyle),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dodocoins', style: labelStyle),
              Text('+$dodocoins\u20BD', style: valueStyle),
            ],
          ),
        ],
      ),
    );
  }
}
