import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

class PriceChip extends StatelessWidget {
  final String price;

  const PriceChip({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        AppLocalizations.of(context).productPrice(price),
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
