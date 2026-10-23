import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/core/theme/app_theme.dart';
import 'package:pizza_app/features/menu/presentation/widgets/featured_list.dart';
import 'package:pizza_app/features/menu/presentation/widgets/stories_list.dart';

class MenuSheet extends StatelessWidget {
  const MenuSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.directional(top: AppSpacing.screenHorizontal),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppTheme.surfaceBackgroundColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.directional(
                start: AppSpacing.screenHorizontal,
                top: AppSpacing.screenHorizontal,
              ),
              child: StoriesList(),
            ),
            Padding(
              padding: EdgeInsetsGeometry.directional(
                start: AppSpacing.screenHorizontal,
                top: AppSpacing.screenHorizontal,
              ),
              child: FeaturedList(),
            ),
          ],
        ),
      ),
    );
  }
}
