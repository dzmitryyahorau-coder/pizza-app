import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
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
                  onChangeActiveCategoryId: (id) {
                    setState(() {
                      selectedCategoryId = id;
                    });
                    final ctx = categoryIdToKey[id]?.currentContext;
                    if (ctx != null) {
                      Scrollable.ensureVisible(
                        ctx,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                  },
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
                        padding: EdgeInsetsGeometry.all(
                          AppSpacing.screenHorizontal,
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
