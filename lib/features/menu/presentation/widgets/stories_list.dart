import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/menu/mock/menu_mock_data.dart' as mocks;
import 'package:pizza_app/features/menu/presentation/widgets/story_card.dart';

class StoriesList extends StatelessWidget {
  const StoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final story in mocks.stories)
            Padding(
              padding: EdgeInsetsGeometry.directional(end: AppSpacing.m),
              child: StoryCard(story: story),
            ),
        ],
      ),
    );
  }
}
