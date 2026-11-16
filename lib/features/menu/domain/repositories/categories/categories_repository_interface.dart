import 'package:pizza_app/features/menu/data/models/category.dart';

abstract interface class ICategoriesRepository {
  Future<List<Category>> getCategories();
}
