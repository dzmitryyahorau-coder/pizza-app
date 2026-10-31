import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/product_details/mock/product_details_mock.dart'
    as mocks;
import 'package:pizza_app/features/product_details/presentation/widgets/common/show_more_button.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/toping_card.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

class AddTopings extends StatelessWidget {
  const AddTopings({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.all(AppSpacing.l),
            child: Text(
              l.productAddToTasteSectionTitle,
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
            itemCount: mocks.ingredients.length,
            itemBuilder: (context, index) {
              final item = mocks.ingredients[index];

              return TopingCard(
                title: item.name,
                weight: item.weightGrams,
                price: item.price,
                imgPath: item.imageAsset,
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
