import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/menu/data/product.dart';
import 'package:pizza_app/features/menu/presentation/widgets/categories_list.dart';
import 'package:pizza_app/features/menu/mock/menu_mock_data.dart' as mocks;
import 'package:pizza_app/features/menu/presentation/widgets/product_item.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<StatefulWidget> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = mocks.products
        .where(
          (p) => selectedCategoryId != null
              ? p.categoryId == selectedCategoryId
              : true,
        )
        .toList();

    return Column(
      children: [
        CategoriesList(
          categories: mocks.categories,
          activeCategoryId: selectedCategoryId,
          onChangeActiveCategoryId: (id) => setState(() {
            selectedCategoryId = id;
          }),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 5,
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: ProductItem(product: filteredProducts[index]),
            ),
            itemCount: filteredProducts.length,
          ),
        ),
      ],
    );

    // return CustomScrollView(
    //   slivers: <Widget>[
    //     SliverAppBar(
    //       flexibleSpace: CategoriesList(
    //         categories: mocks.categories,
    //         activeCategoryId: selectedCategoryId,
    //         onChangeActiveCategoryId: (id) => setState(() {
    //           selectedCategoryId = id;
    //         }),
    //       ),
    //     ),
    //     SliverList.builder(
    //       itemBuilder: (BuildContext context, int index) {
    //         return Padding(
    //           padding: EdgeInsetsGeometry.symmetric(
    //             vertical: 5,
    //             horizontal: AppSpacing.screenHorizontal,
    //           ),
    //           child: ProductItem(product: mocks.products[index]),
    //         );
    //       },
    //     ),
    //   ],
    // );
  }
}
