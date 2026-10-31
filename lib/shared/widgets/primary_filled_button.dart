import 'package:flutter/material.dart';

class PrimaryFilledButton extends StatelessWidget {
  const PrimaryFilledButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  });

  final void Function() onPressed;
  final String label;
  final Icon? icon;
  static const Size _size = Size(235, 52);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
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
        children: [?icon, Text(label)],
      ),
    );
  }
}
