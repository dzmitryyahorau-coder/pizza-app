import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/core/theme/app_theme.dart';
import 'package:pizza_app/features/menu/mock/menu_mock_data.dart' as mocks;
import 'package:pizza_app/features/menu/presentation/widgets/categories_list.dart';
import 'package:pizza_app/features/menu/presentation/widgets/menu_header.dart';
import 'package:pizza_app/features/menu/presentation/widgets/menu_sheet.dart';
import 'package:pizza_app/features/menu/presentation/widgets/product_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenuScreenState();
  }
}

class _MenuScreenState extends State<MenuScreen> {
  String? selectedCategoryId;
  Map<String, GlobalKey> categoryIdToKey = {
    for (final category in mocks.categories) category.id: GlobalKey(),
  };

  late final ScrollController _controller;

  bool _isProgmmaticScroll = false;
  static const double _tabsHeight = 56;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isProgmmaticScroll || !_controller.hasClients) return;

    final position = _controller.position;
    final theshold = position.pixels + _tabsHeight + 1;
    final atBottom = position.pixels >= position.maxScrollExtent - 1;

    String? activeId;

    for (final category in mocks.categories) {
      final renderObject = categoryIdToKey[category.id]?.currentContext
          ?.findRenderObject();
      if (renderObject == null) continue;

      final headerOffset = RenderAbstractViewport.of(renderObject)
          .getOffsetToReveal(renderObject, 0)
          .offset;

      if (atBottom || headerOffset <= theshold) {
        activeId = category.id;
      } else {
        break;
      }
    }

    activeId ??= mocks.categories.first.id;
    if (activeId != selectedCategoryId) {
      setState(() {
        selectedCategoryId = activeId;
      });
    }
  }

  Future<void> _scrollToCategory(String id) async {
    setState(() {
      selectedCategoryId = id;
    });

    final context = categoryIdToKey[id]?.currentContext;
    if (context == null) return;

    _isProgmmaticScroll = true;

    try {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } finally {
      _isProgmmaticScroll = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [MenuHeader(), MenuSheet()],
              ),
            ),
            PinnedHeaderSliver(
              child: ColoredBox(
                color: Colors.white,
                child: CategoriesList(
                  categories: mocks.categories,
                  activeCategoryId: selectedCategoryId,
                  onChangeActiveCategoryId: _scrollToCategory,
                ),
              ),
            ),
            for (final category in mocks.categories)
              DecoratedSliver(
                decoration: BoxDecoration(color: Colors.white),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(key: categoryIdToKey[category.id]),
                    SliverList.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: AppSpacing.l,
                          vertical: 8,
                        ),
                        child: ProductItem(
                          product: mocks.products
                              .where((p) => p.categoryId == category.id)
                              .toList()[index],
                        ),
                      ),
                      itemCount: mocks.products
                          .where((p) => p.categoryId == category.id)
                          .length,
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
