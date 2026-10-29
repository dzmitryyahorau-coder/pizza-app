import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/product_details/data/product_details.dart';
import 'package:pizza_app/features/product_details/data/product_size.dart';
import 'package:pizza_app/features/product_details/mock/product_details_mock.dart'
    as mock;
import 'package:pizza_app/features/product_details/presentation/widgets/blured_surface.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/button_with_icon.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/close_icon_button.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/horizontal_selector.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() {
    return _ProductDetailsState();
  }
}

class _ProductDetailsState extends State<ProductDetailsScreen> {
  late final ProductDetails productDetails;

  ProductSize? selectedProductSize;

  @override
  void initState() {
    super.initState();
    productDetails = mock.productDetails.firstWhere(
      (p) => p.id == widget.productId,
    );

    selectedProductSize = productDetails.sizes[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/product-details-bg.png',
            fit: BoxFit.cover,
          ),
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
                BluredSurface(
                  child: Column(
                    spacing: AppSpacing.l,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        productDetails.name,
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
                        child: Text(
                          productDetails.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 235,
                        child: Column(
                          spacing: AppSpacing.l,
                          children: [
                            HorizontalSelector<ProductSize>(
                              options: productDetails.sizes,
                              selected: selectedProductSize!,
                              onSelected: (option) {
                                setState(() {
                                  selectedProductSize = option;
                                });
                              },
                              labelBuilder: (ProductSize p) =>
                                  AppLocalizations.of(context)
                                      .productSizeCm(p.cm),
                            ),
                            ButtonWithIcon(
                              label: AppLocalizations.of(context)
                                  .productPrice(549),
                              onPress: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
