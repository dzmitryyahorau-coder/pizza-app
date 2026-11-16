import 'package:flutter/material.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/product_details/data/models/ingredient.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/ingredient_chip.dart';
import 'package:pizza_app/features/product_details/presentation/l10n/ingredient_l10n.dart';

class SettingsIngredients extends StatelessWidget {
  const SettingsIngredients({
    super.key,
    required this.items,
    required this.onTapIngredient,
    this.removedIngredientIds = const {},
  });

  final void Function(Ingredient) onTapIngredient;

  final List<Ingredient> items;
  final Set<String> removedIngredientIds;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppSpacing.l),
        child: Wrap(
          spacing: AppSpacing.s,
          runSpacing: AppSpacing.s,
          children: [
            for (final item in items)
              InkWell(
                child: IngredientChip(
                  title: l10n.ingredientName(item.ingredientKey),
                  isRemoved: removedIngredientIds.contains(item.id),
                ),
                onTap: () => onTapIngredient(item),
              ),
          ],
        ),
      ),
    );
  }
}
