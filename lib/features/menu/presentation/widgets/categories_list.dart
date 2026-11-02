import 'package:flutter/material.dart';
import 'package:pizza_app/features/menu/data/category.dart';
import 'package:pizza_app/features/menu/presentation/widgets/category_tab_item.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    this.activeCategoryId,
    required this.onChangeActiveCategoryId,
  });

  final List<Category> categories;
  final String? activeCategoryId;
  final void Function(String id) onChangeActiveCategoryId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => CategoryTabItem(
          category: categories[index],
          onSelected: onChangeActiveCategoryId,
          isActive: activeCategoryId == categories[index].id,
        ),
        separatorBuilder: (context, index) => Center(),
      ),
    );
  }
}
