import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/menu/data/product.dart';
import 'package:pizza_app/features/menu/mock/menu_mock_data.dart' as mocks;
import 'package:pizza_app/features/menu/presentation/widgets/categories_list.dart';
import 'package:pizza_app/features/menu/presentation/widgets/menu_header.dart';
import 'package:pizza_app/features/menu/presentation/widgets/menu_sheet.dart';
import 'package:pizza_app/features/menu/presentation/widgets/product_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static const double _tabsHeight = 56;

  late final ScrollController _controller;

  final Map<String, double> _sectionOffsets = {};

  /// Products by category, calculated once
  late final _productsByCategory = {
    for (final category in mocks.categories)
      category.id: mocks.products
          .where((p) => p.categoryId == category.id)
          .toList(),
  };

  String? selectedCategoryId;
  bool _isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
    selectedCategoryId = mocks.categories.firstOrNull?.id;
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
    for (final category in mocks.categories) {
      final start = _sectionOffsets[category.id];
      if (start == null) continue;

      if (atBottom || start <= line) {
        activeId = category.id;
      } else {
        break;
      }
    }

    activeId ??= mocks.categories.firstOrNull?.id;
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
    final surface = context.appColors.surface;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            const SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [MenuHeader(), MenuSheet()],
              ),
            ),
            PinnedHeaderSliver(
              child: ColoredBox(
                color: surface,
                child: CategoriesList(
                  categories: mocks.categories,
                  activeCategoryId: selectedCategoryId,
                  onChangeActiveCategoryId: _scrollToCategory,
                ),
              ),
            ),
            for (final category in mocks.categories)
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
        child: ProductItem(product: products[index]),
      ),
    );
  }
}
