class Dough {
  const Dough({
    required this.id,
    required this.name,
    required this.imageAsset,
    this.extraPrice = 0,
  });

  final String id;
  final String name;
  final String imageAsset;
  final double extraPrice;
}
