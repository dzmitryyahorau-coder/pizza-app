import 'package:flutter/material.dart';
import 'package:pizza_app/shared/widgets/primary_filled_button.dart';

class PriceButton extends StatelessWidget {
  final String label;
  final Icon icon;
  final void Function() onPress;

  const PriceButton({
    super.key,
    required this.label,
    required this.onPress,
    this.icon = const Icon(Icons.add, size: 20),
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryFilledButton(onPressed: onPress, label: label);
  }
}
