import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/features/product_details/data/models/dough.dart';
import 'package:pizza_app/features/product_details/data/models/ingredient.dart';
import 'package:pizza_app/features/product_details/data/models/product_details.dart';
import 'package:pizza_app/features/product_details/data/models/product_size.dart';
import 'package:pizza_app/features/product_details/data/models/topping.dart';
import 'package:pizza_app/features/product_details/data/repository/ingredients_repository.dart';
import 'package:pizza_app/features/product_details/data/repository/product_details_repository.dart';
import 'package:pizza_app/features/product_details/data/repository/topings_repository.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/customize_mode/customize_mode_view.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/default_mode/default_mode_view.dart';

class ProductDetailsScreen extends StatefulWidget {
  final IProductDetailsRepository? productDetailsRepository;
  final IToppingsRepository? toppingsRepository;
  final IIngredientsRepository? ingredientsRepository;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
    this.productDetailsRepository,
    this.toppingsRepository,
    this.ingredientsRepository,
  });

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsScreen> {
  late final IProductDetailsRepository _productDetailsRepository;
  late final IToppingsRepository _toppingsRepository;
  late final IIngredientsRepository _ingredientsRepository;

  late ProductSize selectedProductSize;
  late Dough selectedDough;

  ProductDetails? _details;
  List<Topping> _toppings = [];
  List<Ingredient> _ingredients = [];
  bool _isCustomizeMode = false;
  bool _isLoading = true;
  String? _errorMessage;

  Future<void> _fetchProductDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final details = await  _productDetailsRepository.getProductDetails(widget.productId);
      if (!mounted) return;

      setState(() {
        _details = details;
        _errorMessage = details == null ? 'Product not found' : null;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchToppings() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final toppings = await _toppingsRepository.getToppings();
      if (!mounted) return;

      setState(() {
        _toppings = toppings;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchIngredients() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final ingredients = await _ingredientsRepository.getIngredients();
      if (!mounted) return;

      setState(() {
        _ingredients = ingredients;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _productDetailsRepository = widget.productDetailsRepository ?? FirestoreProductDetailsRepository();
    _toppingsRepository = widget.toppingsRepository ?? FirestoreToppingsRepository();
    _ingredientsRepository = widget.ingredientsRepository ?? FirestoreIngredientsRepository();

    (_fetchProductDetails(), _fetchToppings(), _fetchIngredients()).wait;
  }

  void toggleCustomizationMode() {
    setState(() {
      _isCustomizeMode = !_isCustomizeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final details = _details;
    final toppings = _toppings;
    final ingredients = _ingredients;
    final isUnsupported =
        details != null && (details.sizes.isEmpty || details.doughs.isEmpty);

    if (_errorMessage != null || details == null || isUnsupported) {
      return Scaffold(
        appBar: AppBar(leading: BackButton(onPressed: () => context.pop())),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Text(_errorMessage ?? 'This product cannot be customized'), /// temporary filling, will be another screen
              FilledButton(
                onPressed: _fetchProductDetails,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return _ProductDetailsView(details: details, toppings: toppings, ingredients: ingredients);
  }
}

class _ProductDetailsView extends StatefulWidget {
  const _ProductDetailsView({required this.details, required this.toppings, required this.ingredients});

  final ProductDetails details;
  final List<Topping> toppings;
  final List<Ingredient> ingredients;

  @override
  State<_ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<_ProductDetailsView> {
  late ProductSize selectedProductSize;
  late Dough selectedDough;
  bool _isCustomizeMode = false;

  @override
  void initState() {
    super.initState();
    final details = widget.details;

    selectedProductSize = details.sizes.firstWhere(
      (s) => s.id == details.defaultSizeId,
      orElse: () => details.sizes.first,
    );
    selectedDough = details.doughs.firstWhere(
      (d) => d.id == details.defaultDoughId,
      orElse: () => details.doughs.first,
    );
  }

  void _toggleCustomizationMode() {
    setState(() => _isCustomizeMode = !_isCustomizeMode);
  }

  @override
  Widget build(BuildContext context) {
    final (details, toppings, ingredients) = (widget.details, widget.toppings, widget.ingredients);

    final body = _isCustomizeMode
        ? CustomizeModeView(
            title: details.name,
            size: selectedProductSize,
            toppings: details.toppings,
            ingredients: details.ingredients,
            selectedDough: selectedDough,
            doughs: details.doughs,
            onSelectDoughType: (d) => setState(() => selectedDough = d),
            onCloseView: _toggleCustomizationMode,
          )
        : DefaultModeView(
            title: details.name,
            description: details.description,
            sizes: details.sizes,
            selectedSize: selectedProductSize,
            price: selectedProductSize.price,
            onSelectedSize: (s) => setState(() => selectedProductSize = s),
            onPressCustomizationButton: _toggleCustomizationMode,
            onClose: () => context.pop(),
          );

    return Scaffold(body: body);
  }
}
