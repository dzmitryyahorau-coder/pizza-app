import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/features/menu/data/models/category.dart';

class CategoryTabItem extends StatelessWidget {
  const CategoryTabItem({
    super.key,
    required this.category,
    required this.onSelected,
    this.isActive = false,
  });

  final VoidCallback onSelected;
  final bool isActive;

  final Category category;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent,
      ),
      onPressed: onSelected,
      child: Text(
        category.name,
        style: TextStyle(
          color: isActive
              ? context.appColors.onSurface
              : context.appColors.onSurfaceVariant,
        ),
      ),
    );
  }
}
