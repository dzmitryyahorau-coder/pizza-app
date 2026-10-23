import 'package:flutter/material.dart';
import 'package:pizza_app/features/menu/data/category.dart';

/*
warning • This class (or a class that this class
       inherits from) is marked as '@immutable', but
       one or more of its instance fields aren't
       final: CategoriesList.activeCategoryId •
       lib/features/menu/presentation/widgets/categor
       ies_list.dart:4:7 • must_be_immutable
       */
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
              color: Color.fromARGB(
                categories[index].id == activeCategoryId ? 255 : 60,
                23,
                23,
                23,
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => Center(),
      ),
    );
  }
}
