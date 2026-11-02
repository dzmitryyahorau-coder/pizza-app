import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_colors.dart';

abstract final class AppTheme {
  static final ThemeData light = _build(Brightness.light, AppColors.light);
  static final ThemeData dark = _build(Brightness.dark, AppColors.dark);

  static ThemeData _build(Brightness brightness, AppColors colors) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: colors.scaffoldBackground,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: colors.brandColor,
            brightness: brightness,
          ).copyWith(
            surface: colors.surface,
            onSurface: colors.onSurface,
            onSurfaceVariant: colors.onSurfaceVariant,
          ),
      extensions: [colors],
    );
  }
}
