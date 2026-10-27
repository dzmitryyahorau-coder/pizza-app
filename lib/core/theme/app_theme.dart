import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_colors.dart';

abstract final class AppTheme {
  static const Color _brand = Color(0xFFFF6900);

  static final ThemeData light = _build(
    brightness: Brightness.light,
    scaffold: const Color(0xFFF1F3F6),
    surface: const Color(0xFFFFFFFF),
    onSurface: const Color(0xFF171717),
    onSurfaceVariant: const Color(0xFF8A8A8E),
    colors: AppColors.light,
  );

  static final ThemeData dark = _build(
    brightness: Brightness.dark,
    scaffold: const Color(0xFF000000),
    surface: const Color(0xFF1A1A1A),
    onSurface: const Color(0xFFFFFFFF),
    onSurfaceVariant: const Color(0x80FFFFFF),
    colors: AppColors.dark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color scaffold,
    required Color surface,
    required Color onSurface,
    required Color onSurfaceVariant,
    required AppColors colors,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: scaffold,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: _brand,
            brightness: brightness,
          ).copyWith(
            surface: surface,
            onSurface: onSurface,
            onSurfaceVariant: onSurfaceVariant,
          ),
      extensions: [colors],
    );
  }
}
