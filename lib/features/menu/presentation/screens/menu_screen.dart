import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/menu/data/models/category.dart';
import 'package:pizza_app/features/menu/data/models/product.dart';
import 'package:pizza_app/features/menu/data/models/story.dart';
import 'package:pizza_app/features/menu/data/repositories/categories_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/product_repository.dart';
import 'package:pizza_app/features/menu/data/repositories/stories_repository.dart';
import 'package:pizza_app/features/menu/presentation/widgets/categories_list.dart';
import 'package:pizza_app/features/menu/presentation/widgets/menu_header.dart';
import 'package:pizza_app/features/menu/presentation/widgets/menu_sheet.dart';
import 'package:pizza_app/features/menu/presentation/widgets/product_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
    this.productsRepository,
    this.categoriesRepository,
    this.storiesRepository,
  });

  final IProductsRepository? productsRepository;
  final ICategoriesRepository? categoriesRepository;
  final IStoriesRepository? storiesRepository;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static const double _tabsHeight = 56;

  late final ScrollController _controller;
  late final IProductsRepository _productsRepository;
  late final ICategoriesRepository _categoriesRepository;
  late final IStoriesRepository _storiesRepository;

  final Map<String, double> _sectionOffsets = {};

  List<Category> _categories = [];
  List<Story> _stories = [];
  Map<String, List<Product>> _productsByCategory = {};

  bool _isLoading = true;
  String? _errorMessage;

  String? selectedCategoryId;
  bool _isProgrammaticScroll = false;

  Future<void> _fetchMenu() async {
    final isInitialLoad = _categories.isEmpty;

    setState(() {
      _errorMessage = null;
      if (isInitialLoad) _isLoading = true;
    });

    try {
      final (categories, products, stories) = await (
        _categoriesRepository.getCategories(),
        _productsRepository.getProducts(),
        _storiesRepository.getStories(),
      ).wait;

      final grouped = <String, List<Product>>{
        for (final category in categories) category.id: [],
      };
      for (final product in products) {
        grouped[product.categoryId]?.add(product);
      }

      if (!mounted) return;
      setState(() {
        _categories = categories;
        _stories = stories;
        _productsByCategory = grouped;

        final selectedStillExists = categories.any(
          (c) => c.id == selectedCategoryId,
        );
        if (!selectedStillExists) {
          selectedCategoryId = categories.firstOrNull?.id;
        }

        _sectionOffsets.clear();
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Menu load failed: $e');
      if (!mounted) return;
      if (isInitialLoad) {
        setState(() {
          _errorMessage = 'Error during the loading of menu data';
          _isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not refresh the menu')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
    _productsRepository =
        widget.productsRepository ?? FirestoreProductsRepository();
    _categoriesRepository =
        widget.categoriesRepository ?? FirestoreCategoriesRepository();
    _storiesRepository =
        widget.storiesRepository ?? FirestoreStoriesRepository();
    _fetchMenu();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isProgrammaticScroll ||
        !_controller.hasClients ||
        _sectionOffsets.isEmpty) {
      return;
    }

    final position = _controller.position;
    final line = position.pixels + _tabsHeight + 1;
    final atBottom = position.pixels >= position.maxScrollExtent - 1;

    String? activeId;
    for (final category in _categories) {
      final start = _sectionOffsets[category.id];
      if (start == null) continue;

      if (atBottom || start <= line) {
        activeId = category.id;
      } else {
        break;
      }
    }

    activeId ??= _categories.firstOrNull?.id;
    if (activeId != null && activeId != selectedCategoryId) {
      setState(() => selectedCategoryId = activeId);
    }
  }

  Future<void> _scrollToCategory(String id) async {
    setState(() => selectedCategoryId = id);

    final start = _sectionOffsets[id];
    if (start == null || !_controller.hasClients) return;

    final position = _controller.position;
    final target = (start - _tabsHeight)
        .clamp(position.minScrollExtent, position.maxScrollExtent)
        .toDouble();

    _isProgrammaticScroll = true;
    try {
      await _controller.animateTo(
        target,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } finally {
      _isProgrammaticScroll = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final errorMessage = _errorMessage;
    if (errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.l,
            children: [
              Text(errorMessage),
              FilledButton(
                onPressed: _fetchMenu,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final surface = context.appColors.surface;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: _fetchMenu,
          child: CustomScrollView(
            controller: _controller,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const MenuHeader(),
                    MenuSheet(storiesList: _stories),
                  ],
                ),
              ),
              PinnedHeaderSliver(
                child: ColoredBox(
                  color: surface,
                  child: CategoriesList(
                    categories: _categories,
                    activeCategoryId: selectedCategoryId,
                    onChangeActiveCategoryId: _scrollToCategory,
                  ),
                ),
              ),
              for (final category in _categories)
                DecoratedSliver(
                  decoration: BoxDecoration(color: surface),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverLayoutBuilder(
                        builder: (context, constraints) {
                          _sectionOffsets[category.id] =
                              constraints.precedingScrollExtent;
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        },
                      ),
                      _ProductsSliver(
                        products: _productsByCategory[category.id] ?? const [],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductsSliver extends StatelessWidget {
  const _ProductsSliver({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: 8,
        ),
        child: InkWell(
          child: ProductItem(product: products[index]),
          onTap: () => context.push('/products/${products[index].id}'),
        ),
      ),
    );
  }
}