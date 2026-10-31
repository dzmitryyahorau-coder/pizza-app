import 'package:flutter/material.dart';

/// Цвета, для которых нет готовой роли в ColorScheme
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.chipBackground,
    required this.accentGreen,
    required this.onChip,
  });

  final Color chipBackground;
  final Color onChip;
  final Color accentGreen;

  static const light = AppColors(
    chipBackground: Color(0xFFF1F3F6),
    onChip: Color(0xFF000000),
    accentGreen: Color(0xFF00AB48),
  );

  static const dark = AppColors(
    chipBackground: Color(0xFF2A2A2A),
    accentGreen: Color(0xFF1EA557),
    onChip: Color(0xFFFFFFFF),
  );

  @override
  AppColors copyWith({
    Color? chipBackground,
    Color? accentGreen,
    Color? onChip,
  }) => AppColors(
    chipBackground: chipBackground ?? this.chipBackground,
    onChip: onChip ?? this.onChip,
    accentGreen: accentGreen ?? this.accentGreen,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      chipBackground: Color.lerp(chipBackground, other.chipBackground, t)!,
      onChip: Color.lerp(onChip, other.onChip, t)!,
      accentGreen: Color.lerp(accentGreen, other.accentGreen, t)!,
    );
  }
}

extension AppColorsX on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
