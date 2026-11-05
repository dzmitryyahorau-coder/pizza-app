import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory Story.fromFireStore(
    DocumentSnapshot snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('Document is empty');
    }

    return Story(
      label: data['label'] as String,
      image: data['image'] as String,
      badge: data['badge'] as String?,
      bgColor: _colorFromHex(data['bgColor'] as String?),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'image': image,
      if (bgColor != null) 'bgColor': _colorToHex(bgColor!),
      if (badge != null) 'badge': badge,
    };
  }

  /// "#RRGGBB" (or "RRGGBB") -> Color, in the error format - null
  static Color? _colorFromHex(String? hex) {
    if (hex == null) return null;

    final cleaned = hex.replaceFirst('#', '');
    if (cleaned.length != 6) return null;

    final rgb = int.tryParse(cleaned, radix: 16);
    if (rgb == null) return null;

    return Color(0xFF000000 | rgb);
  }

  /// Color -> "#RRGGBB"
  static String _colorToHex(Color color) {
    final rgb = color.toARGB32() & 0xFFFFFF;
    return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}
