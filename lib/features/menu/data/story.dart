import 'dart:ui';

class Story {
  final String label;
  final String image;
  final Color? bgColor;
  final String? badge;

  const Story({
    required this.label,
    required this.image,
    this.badge,
    this.bgColor,
  });
}
