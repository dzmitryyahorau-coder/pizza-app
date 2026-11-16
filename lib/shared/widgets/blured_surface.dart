import 'dart:ui';

import 'package:flutter/material.dart';

class BluredSurface extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry borderRadius;
  final double darkness;

  const BluredSurface({
    super.key,
    required this.child,
    this.borderRadius = BorderRadiusGeometry.zero,
    this.darkness = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          color: Colors.black.withValues(alpha: darkness),
          child: child,
        ),
      ),
    );
  }
}
