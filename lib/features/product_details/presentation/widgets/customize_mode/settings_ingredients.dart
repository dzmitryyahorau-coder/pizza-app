import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/product_details/data/ingredient.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/ingredient_chip.dart';

class SettingsIngredients extends StatelessWidget {
  const SettingsIngredients({super.key, required this.items});

  final List<Ingredient> items;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppSpacing.l),
        child: Wrap(
          spacing: AppSpacing.s,
          runSpacing: AppSpacing.s,
          children: [
            for (final item in items) IngredientChip(title: item.name),
          ],
        ),
      ),
    );
  }
}
