import 'package:pizza_app/features/menu/data/models/category.dart';
import 'package:pizza_app/features/menu/data/repositories/categories/categories_repository_interface.dart';

class InmemoryCategoriesRepository implements ICategoriesRepository {
  final List<Category> _store;

  InmemoryCategoriesRepository({List<Category>? store}) : _store = store ?? [];

  @override
  Future<List<Category>> getCategories() {
    return Future.sync(() => _store);
  }
}
