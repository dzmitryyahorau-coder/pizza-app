class Topping {
  const Topping({
    required this.id,
    required this.name,
    required this.weightGrams,
    required this.price,
    required this.imageAsset,
  });

  final String id;
  final String name;
  final int weightGrams;
  final double price;
  final String imageAsset;
}
