import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/menu/presentation/widgets/featured_list.dart';
import 'package:pizza_app/features/menu/presentation/widgets/stories_list.dart';

class MenuSheet extends StatelessWidget {
  const MenuSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.directional(top: AppSpacing.l),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.directional(
                start: AppSpacing.l,
                top: AppSpacing.l,
              ),
              child: StoriesList(),
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
