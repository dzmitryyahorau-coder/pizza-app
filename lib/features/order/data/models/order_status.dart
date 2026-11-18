enum OrderStatus {
  processing, // обработка
  preparing, // готовится
  assembling, // собираем
  delivering, // везём
  delivered, // доставлен
  cancelled; // отменён

  /// Неизвестное значение из базы не должно ронять приложение.
  static OrderStatus fromString(String? value) {
    return OrderStatus.values.firstWhere(
      (s) => s.name == value,
      orElse: () => OrderStatus.processing,
    );
  }
}
