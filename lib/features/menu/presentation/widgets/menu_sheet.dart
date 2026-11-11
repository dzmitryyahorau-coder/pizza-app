import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/menu/data/models/story.dart';
import 'package:pizza_app/features/menu/presentation/widgets/featured_list.dart';
import 'package:pizza_app/features/menu/presentation/widgets/stories_list.dart';
import 'package:pizza_app/core/theme/app_colors.dart';

class MenuSheet extends StatelessWidget {
  final List<Story> storiesList;

  const MenuSheet({super.key, required this.storiesList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.directional(top: AppSpacing.l),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.directional(
                start: AppSpacing.l,
                top: AppSpacing.l,
              ),
              child: StoriesList(stories: storiesList),
            ),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                start: AppSpacing.l,
                top: AppSpacing.l,
              ),
              child: FeaturedList(),
            ),
          ],
        ),
      ),
    );
  }
}
