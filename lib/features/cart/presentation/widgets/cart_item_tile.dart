import 'package:flutter/material.dart';
import 'package:pizza_app/core/database/app_database.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/cart/presentation/widgets/cart_item_counter.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    this.onChange,
  });

  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback? onChange;

  static const double _imageSize = 72;
  static const double _imageGap = 21;
  static const double _titleTopOffset = 5;
  static const double _gapTitleToDetails = 5;
  static const double _gapDetailsToChange = 14;
  static const double _gapChangeToCounter = 18;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = context.l10n;

    final details = [
      item.sizeName,
      item.doughName,
    ].where((s) => s != null && s.isNotEmpty).join(', ');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: colors.chipBackground)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.l),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                item.imageAsset,
                width: _imageSize,
                height: _imageSize,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: _imageGap),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: _titleTopOffset),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colors.onSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      if (details.isNotEmpty) ...[
                        const SizedBox(height: _gapTitleToDetails),
                        Text(
                          details,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 12,
                            height: 1.2,
                          ),
                        ),
                      ],
                      const SizedBox(height: _gapDetailsToChange),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: onChange,
                        child: Text(
                          l10n.changeButton,
                          style: TextStyle(
                            color: colors.brandColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: _gapChangeToCounter),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CartItemCounter(
                            value: item.quantity,
                            onDecrement: onDecrement,
                            onIncrement: onIncrement,
                          ),
                          const Spacer(),
                          Text(
                            l10n.productPrice(item.price * item.quantity),
                            style: TextStyle(
                              color: colors.onSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
