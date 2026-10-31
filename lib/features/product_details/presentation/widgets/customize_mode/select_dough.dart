import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/product_details/data/dough.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/dough_button.dart';

class SelectDough extends StatelessWidget {
  const SelectDough({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelect,
  });

  final List<Dough> items;
  final Dough selected;
  final ValueChanged<Dough> onSelect;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.l),
        child: Row(
          spacing: AppSpacing.s,
          children: [
            for (final item in items)
              Expanded(
                child: DoughButton(
                  dough: item,
                  isActive: selected.id == item.id,
                  onPress: () => onSelect(item),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
