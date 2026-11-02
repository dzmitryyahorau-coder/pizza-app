import 'package:flutter/material.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';

class PriceChip extends StatelessWidget {
  final String price;

  const PriceChip({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        context.l10n.productPrice(price),
        style: TextStyle(color: context.appColors.onChip),
      ),
      backgroundColor: context.appColors.chipBackground,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: TextStyle(fontWeight: FontWeight.w500),
      labelPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
    );
  }
}
