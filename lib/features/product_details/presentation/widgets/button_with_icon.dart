import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final String label;
  final Icon? icon;
  final void Function() onPress;

  const ButtonWithIcon({
    super.key,
    required this.label,
    required this.onPress,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPress,
      style: ButtonStyle(
        padding: WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
        backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFFF6400)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.add),
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
