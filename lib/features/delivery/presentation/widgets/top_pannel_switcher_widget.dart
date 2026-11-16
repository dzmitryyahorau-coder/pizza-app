import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/shared/widgets/blured_surface.dart';
import 'package:pizza_app/shared/widgets/close_icon_button.dart';
import 'package:pizza_app/shared/widgets/primary_filled_button.dart';

class TopPannelSwitcherWidget extends StatelessWidget {
  const TopPannelSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: AppSpacing.m,
        ),
        child: Row(
          children: [
            CloseIconButton(onPress: () => context.pop()),
            const SizedBox(width: AppSpacing.m),

            // Switcher Delivery / In the store
            Expanded(
              child: BluredSurface(
                darkness: 0.5,
                borderRadius: BorderRadiusGeometry.circular(32),
                child: Row(
                  children: [
                    // Actie delivery btn Delivery
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(AppSpacing.m),
                        decoration: BoxDecoration(
                          color: colors.brandColor,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: PrimaryFilledButton(
                          icon: Icon(
                            Icons.directions_bike,
                            color: Colors.white,
                            size: 18,
                          ),
                          onPressed: () {},
                          label: 'Delivery',
                        ),
                      ),
                    ),
                    // inactive btn In the store
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.restaurant,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'In the store',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
