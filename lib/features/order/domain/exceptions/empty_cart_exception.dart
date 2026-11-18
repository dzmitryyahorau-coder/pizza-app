class EmptyCartException implements Exception {
  const EmptyCartException();

  @override
  String toString() => 'EmptyCartException: cart is empty';
}
