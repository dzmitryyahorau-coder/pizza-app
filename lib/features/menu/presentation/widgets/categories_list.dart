import 'package:flutter/material.dart';
import 'package:pizza_app/features/menu/data/category.dart';

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
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => TextButton(
          style: TextButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            overlayColor: Colors.transparent,
          ),
          onPressed: () {
            onChangeActiveCategoryId(categories[index].id);
          },
          child: Text(
            categories[index].name,
            style: TextStyle(
              color: activeCategoryId == categories[index].id
                  ? colors.onSurface
                  : colors.onSurfaceVariant,
            ),
          ),
        ),
        separatorBuilder: (context, index) => Center(),
      ),
    );
  }
}
