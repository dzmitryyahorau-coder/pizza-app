import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/product_details/data/product_size.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/common/price_button.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/common/close_icon_button.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/common/background.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/default_mode/customize_button.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/common/horizontal_selector.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

class DefaultModeView extends StatelessWidget {
  final String title;
  final String description;
  final List<ProductSize> sizes;
  final double price;

  final ProductSize selectedSize;

  final void Function(ProductSize) onSelectedSize;
  final void Function() onPressCustomizationButton;

  const DefaultModeView({
    super.key,
    required this.title,
    required this.description,
    required this.sizes,
    required this.price,
    required this.selectedSize,
    required this.onSelectedSize,
    required this.onPressCustomizationButton,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Background(),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(AppSpacing.l),
                  child: CloseIconButton(onPress: () => {}),
                ),
              ),
              Column(
                spacing: AppSpacing.l,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: AppSpacing.l,
                    ),
                    child: SizedBox(
                      width: 312,
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 235,
                    child: Column(
                      spacing: AppSpacing.l,
                      children: [
                        HorizontalSelector<ProductSize>(
                          options: sizes,
                          selected: selectedSize,
                          onSelected: onSelectedSize,
                          labelBuilder: (ProductSize p) =>
                              AppLocalizations.of(context).productSizeCm(p.cm),
                        ),
                        PriceButton(
                          label: AppLocalizations.of(context).productPrice(549),
                          onPress: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.m),
                  CustomizeButton(onPressed: onPressCustomizationButton),
                  SizedBox(height: AppSpacing.xl),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
