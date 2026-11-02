import 'package:flutter/material.dart';
import 'package:pizza_app/features/product_details/data/dough.dart';
import 'package:pizza_app/features/product_details/data/product_details.dart';
import 'package:pizza_app/features/product_details/data/product_size.dart';
import 'package:pizza_app/features/product_details/mock/product_details_mock.dart'
    as mock;
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/customize_mode_view.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/default_mode/default_mode_view.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsScreen> {
  late final ProductDetails productDetails;

  late ProductSize selectedProductSize;
  late Dough selectedDough;
  bool _isCustomizeMode = false;

  @override
  void initState() {
    super.initState();
    productDetails = mock.productDetails.firstWhere(
      (p) => p.id == widget.productId,
    );

    selectedProductSize = productDetails.sizes.firstWhere(
      (s) => s.id == productDetails.defaultSizeId,
    );
    selectedDough = productDetails.doughs.firstWhere(
      (d) => d.id == productDetails.defaultDoughId,
    );
  }

  void toggleCustomizationMode() {
    setState(() {
      _isCustomizeMode = !_isCustomizeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final body = _isCustomizeMode
        ? CustomizeModeView(
            title: productDetails.name,
            size: selectedProductSize,
            ingredients: productDetails.ingredients,
            selectedDough: selectedDough,
            doughs: productDetails.doughs,
            onSelectDoughType: (d) => setState(() => selectedDough = d),
            onCloseView: toggleCustomizationMode,
          )
        : DefaultModeView(
            title: productDetails.name,
            description: productDetails.description,
            sizes: productDetails.sizes,
            selectedSize: selectedProductSize,
            price: selectedProductSize.price,
            onSelectedSize: (s) => setState(() => selectedProductSize = s),
            onPressCustomizationButton: toggleCustomizationMode,
          );

    return Scaffold(body: body);
  }
}
