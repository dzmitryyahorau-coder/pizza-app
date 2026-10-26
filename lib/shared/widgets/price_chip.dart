import 'package:flutter/material.dart';

class PriceChip extends StatelessWidget {
  final String price;

  const PriceChip({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(price),
      backgroundColor: Colors.grey.shade200,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
