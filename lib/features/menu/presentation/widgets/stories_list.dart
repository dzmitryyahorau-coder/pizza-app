import 'package:flutter/material.dart';
import 'package:pizza_app/features/menu/mock/menu_mock_data.dart' as mocks;

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
            Container(
              width: 80,
              height: 110,
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(color: story.bgColor),
              child: Image.asset(story.image),
            ),
        ],
      ),
    );
  }
}
