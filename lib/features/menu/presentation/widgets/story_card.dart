import 'package:flutter/material.dart';
import 'package:pizza_app/features/menu/data/story.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({super.key, required this.story});

  final Story story;

  static const double width = 88;
  static const double height = 110;
  static const double _radius = 16;

  @override
  Widget build(BuildContext context) {
    final bgColor = story.bgColor ?? Colors.black;
    final badgeIcon = _badgeIcon(story.badge);

    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: bgColor),
            Image.asset(
              story.image,
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    bgColor.withValues(alpha: 0),
                    bgColor.withValues(alpha: 0.9),
                  ],
                  stops: const [0.5, 1],
                ),
              ),
            ),
            if (badgeIcon != null)
              Positioned(
                top: 8,
                left: 8,
                child: Icon(badgeIcon, color: Colors.white, size: 20),
              ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: Text(
                story.label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData? _badgeIcon(String? badge) => switch (badge) {
    'sparkles' => Icons.auto_awesome,
    'fire' => Icons.local_fire_department,
    _ => null,
  };
}
