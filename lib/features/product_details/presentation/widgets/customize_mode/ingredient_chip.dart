import 'package:flutter/material.dart';

class IngredientChip extends StatelessWidget {
  final String title;
  final bool isRemoved;

  const IngredientChip({
    super.key,
    required this.title,
    this.isRemoved = false,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Color(0x4D171717),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          left: 16,
          right: 12,
          top: 6,
          bottom: 6,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                decoration: isRemoved ? TextDecoration.lineThrough : null,
              ),
            ),
            Icon(Icons.close, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
