import 'package:equatable/equatable.dart';
import 'package:pizza_app/features/menu/data/models/category.dart';
import 'package:pizza_app/features/menu/data/models/product.dart';
import 'package:pizza_app/features/menu/data/models/story.dart';

enum MenuStatus { init, loading, refreshing, success, failure }

final class MenuState extends Equatable {
  final MenuStatus status;
  final List<Category> categories;
  final List<Story> stories;
  final Map<String, List<Product>> productsByCategory;
  final String? errorMessage;

  const MenuState({
    this.status = MenuStatus.init,
    this.categories = const [],
    this.stories = const [],
    this.productsByCategory = const {},
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    status,
    categories,
    stories,
    productsByCategory,
    errorMessage,
  ];

  MenuState copyWith({MenuStatus? status}) {
    return MenuState(
      status: status ?? this.status,
      categories: categories,
      stories: stories,
      productsByCategory: productsByCategory,
      errorMessage: errorMessage,
    );
  }
}
