import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? hintText;

  const CustomTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      decoration: BoxDecoration(
        color: colors.chipBackground,
        borderRadius: BorderRadius.circular(26),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: TextStyle(
          color: colors.onSurface,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        cursorColor: colors.brandColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: colors.onSurfaceVariant,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
