import 'package:flutter/material.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/cart/presentation/widgets/cart_upcell_card.dart';

class CartUpcellItems extends StatelessWidget {
  const CartUpcellItems({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsetsGeometry.only(bottom: AppSpacing.l),
            child: Text(
              l10n.cartUpcellSectionHead,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              CartUpsellCard(
                title: 'Картофель из печи',
                weight: '190 g',
                imageAsset: 'assets/images/fried.png',
                price: 850,
                onAdd: () {},
              ),
              SizedBox(width: AppSpacing.l),
              CartUpsellCard(
                title: 'Сырный',
                weight: '1 pcs',
                imageAsset: 'assets/images/cheese_souce.png',
                price: 120,
                onAdd: () {},
              ),
              SizedBox(width: AppSpacing.l),
              CartUpsellCard(
                title: 'Pepsi',
                weight: '0,5 ml',
                imageAsset: 'assets/images/pepsi.png',
                price: 520,
                onAdd: () {},
              ),
              SizedBox(width: AppSpacing.l),
              CartUpsellCard(
                title: 'Pepsi',
                weight: '0,5 ml',
                imageAsset: 'assets/images/pepsi.png',
                price: 520,
                onAdd: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
