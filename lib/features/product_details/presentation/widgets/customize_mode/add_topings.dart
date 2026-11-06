import 'package:flutter/material.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/product_details/data/models/topping.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/common/show_more_button.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/toping_card.dart';

class AddToppings extends StatelessWidget {
  const AddToppings({
    super.key,
    required this.toppings,
    this.selectedToppingIds = const {},
    required this.onSelectTopping,
  });

  final List<Topping> toppings;
  final Set<String> selectedToppingIds;
  final void Function(Topping) onSelectTopping;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.all(AppSpacing.l),
            child: Text(
              l10n.productAddToTasteSectionTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: AppSpacing.l),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: AppSpacing.s,
              crossAxisSpacing: AppSpacing.s,
              mainAxisExtent: 166,
            ),
            itemCount: toppings.length,
            itemBuilder: (context, index) {
              final item = toppings[index];

              return TopingCard(
                title: item.name,
                weight: item.weightGrams,
                price: item.price,
                imgPath: item.imageAsset,
                onTap: () => onSelectTopping(item),
                isSelected: selectedToppingIds.contains(item.id),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.all(AppSpacing.l),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ShowMoreButton(onPressed: () {})],
            ),
          ),
        ),
      ],
    );
  }
}
