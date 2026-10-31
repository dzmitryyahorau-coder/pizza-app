import 'package:flutter/material.dart';

class PriceButton extends StatelessWidget {
  final String label;
  final Icon icon;
  final void Function() onPress;

  static const Size _size = Size(235, 52);

  const PriceButton({
    super.key,
    required this.label,
    required this.onPress,
    this.icon = const Icon(Icons.add, size: 20),
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPress,
      style: FilledButton.styleFrom(
        fixedSize: _size,
        padding: EdgeInsets.zero,
        backgroundColor: const Color(0xFFFF6400),
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [icon, Text(label)],
      ),
    );
  }
}
