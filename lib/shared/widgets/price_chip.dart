import 'package:flutter/material.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

class PriceChip extends StatelessWidget {
  final String price;

  const PriceChip({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(AppLocalizations.of(context).productPrice(price)),
      backgroundColor: Colors.grey.shade200,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
