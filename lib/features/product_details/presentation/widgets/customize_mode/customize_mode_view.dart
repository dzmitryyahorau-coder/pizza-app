import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/product_details/data/dough.dart';
import 'package:pizza_app/features/product_details/data/ingredient.dart';
import 'package:pizza_app/features/product_details/data/product_size.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/common/close_icon_button.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/common/price_button.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/add_topings.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/select_dough.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/settings_ingredients.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

class CustomizeModeView extends StatelessWidget {
  final String title;
  final ProductSize size;
  final void Function() onCloseView;
  final List<Ingredient> ingredients;
  final List<Dough> doughs;
  final Dough selectedDough;

  final void Function(Dough) onSelectDoughType;

  const CustomizeModeView({
    super.key,
    required this.title,
    required this.size,
    required this.onCloseView,
    required this.ingredients,
    required this.selectedDough,
    required this.doughs,
    required this.onSelectDoughType,
  });

  static const TextStyle sectionTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/product-customization-bg.png',
          fit: BoxFit.cover,
        ),
        SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(AppSpacing.l),
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CloseIconButton(onPress: onCloseView),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 44 + AppSpacing.l,
                          ),
                          child: Text.rich(
                            TextSpan(
                              text: title,
                              style: sectionTitleStyle,
                              children: [
                                TextSpan(
                                  text:
                                      ' ${localizations.productSizeCm(size.cm)}',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SelectDough(
                items: doughs,
                onSelect: onSelectDoughType,
                selected: selectedDough,
              ),
              AddTopings(),
              SettingsIngredients(items: ingredients),
              SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: AppSpacing.xl * 2,
          child: Center(
            child: PriceButton(
              label: localizations.productPrice(700),
              onPress: () {},
            ),
          ),
        ),
      ],
    );
  }
}
