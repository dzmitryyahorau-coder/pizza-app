import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/menu/data/models/story.dart';
import 'package:pizza_app/features/menu/presentation/widgets/story_card.dart';

class StoriesList extends StatelessWidget {
  final List<Story> stories;

  const StoriesList({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final story in stories)
            Padding(
              padding: EdgeInsetsGeometry.directional(end: AppSpacing.m),
              child: StoryCard(story: story),
            ),
        ],
      ),
    );
  }
}
