import 'package:flutter/material.dart';
import 'package:pizza_app/features/product_details/data/product_details.dart';
import 'package:pizza_app/features/product_details/data/product_size.dart';
import 'package:pizza_app/features/product_details/mock/product_details_mock.dart'
    as mock;
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/customize_mode_view.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/default_mode/default_mode_view.dart';

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
  bool _isCustomizeMode = false;

  @override
  void initState() {
    super.initState();
    productDetails = mock.productDetails.firstWhere(
      (p) => p.id == widget.productId,
    );

    selectedProductSize = productDetails.sizes[1];
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
            size: selectedProductSize!,
            ingredients: productDetails.ingredients,
            selectedDough: productDetails.dough,
            doughs: mock.doughs,
            onSelectDoughType: (d) {
              setState(() {
                productDetails.dough = d;
              });
            },
            onCloseView: toggleCustomizationMode,
          )
        : DefaultModeView(
            title: productDetails.name,
            description: productDetails.description,
            sizes: productDetails.sizes,
            selectedSize: selectedProductSize!,
            price: 699,
            onSelectedSize: (ProductSize s) {
              setState(() {
                selectedProductSize = s;
              });
            },
            onPressCustomizationButton: toggleCustomizationMode,
          );

    return Scaffold(body: body);
  }
}
