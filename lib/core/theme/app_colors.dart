import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brandColor,
    required this.scaffoldBackground,
    required this.surface,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.chipBackground,
    required this.onChip,
    required this.accentGreen,
  });

  final Color brandColor;
  final Color scaffoldBackground;
  final Color surface;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color chipBackground;
  final Color onChip;
  final Color accentGreen;

  static const light = AppColors(
    brandColor: Color(0xFFFF6400),
    scaffoldBackground: Color(0xFFF1F3F6),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF171717),
    onSurfaceVariant: Color(0xFF8A8A8E),
    chipBackground: Color(0xFFF1F3F6),
    onChip: Color(0xFF000000),
    accentGreen: Color(0xFF00AB48),
  );

  static const dark = AppColors(
    brandColor: Color(0xFFFF6400),
    scaffoldBackground: Color(0xFF000000),
    surface: Color(0xFF1A1A1A),
    onSurface: Color(0xFFFFFFFF),
    onSurfaceVariant: Color(0x80FFFFFF),
    chipBackground: Color(0xFF2A2A2A),
    onChip: Color(0xFFFFFFFF),
    accentGreen: Color(0xFF1EA557),
  );

  @override
  AppColors copyWith({
    Color? brandColor,
    Color? scaffoldBackground,
    Color? surface,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? chipBackground,
    Color? onChip,
    Color? accentGreen,
  }) => AppColors(
    brandColor: brandColor ?? this.brandColor,
    scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
    surface: surface ?? this.surface,
    onSurface: onSurface ?? this.onSurface,
    onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
    chipBackground: chipBackground ?? this.chipBackground,
    onChip: onChip ?? this.onChip,
    accentGreen: accentGreen ?? this.accentGreen,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      brandColor: Color.lerp(brandColor, other.brandColor, t)!,
      scaffoldBackground: Color.lerp(
        scaffoldBackground,
        other.scaffoldBackground,
        t,
      )!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceVariant: Color.lerp(
        onSurfaceVariant,
        other.onSurfaceVariant,
        t,
      )!,
      chipBackground: Color.lerp(chipBackground, other.chipBackground, t)!,
      onChip: Color.lerp(onChip, other.onChip, t)!,
      accentGreen: Color.lerp(accentGreen, other.accentGreen, t)!,
    );
  }
}

extension AppColorsX on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
