class ProductSize {
  const ProductSize({required this.id, required this.cm, required this.price});

  final String id;
  final int cm;
  final double price;

  @override
  bool operator ==(Object other) {
    return other is ProductSize && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
