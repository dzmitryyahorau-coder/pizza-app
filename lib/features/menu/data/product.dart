class Product {
  final String id;
  final String categoryId;
  final String name;
  final String description;
  final double price;
  final String? badge;

  const Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    this.badge,
  });
}
