import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(text, style: TextStyle(color: context.appColors.brandColor)),
    );
  }
}
