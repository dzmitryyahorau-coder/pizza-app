import 'package:flutter/material.dart';
import 'package:pizza_app/features/menu/presentation/widgets/categories_list.dart';
import 'package:pizza_app/features/menu/mock/menu_mock_data.dart' as mocks;

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<StatefulWidget> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoriesList(
          categories: mocks.categories,
          activeCategoryId: selectedCategoryId,
          onChangeActiveCategoryId: (id) => setState(() {
            selectedCategoryId = id;
          }),
        ),
      ],
    );
  }
}
