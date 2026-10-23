import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.directional(
        start: AppSpacing.screenHorizontal,
        end: AppSpacing.screenHorizontal,
      ),
      child: Row(
        spacing: 4,
        children: [
          CircleAvatar(backgroundColor: Colors.white, radius: 18),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Тентюковская улица, 333",
                  style: TextStyle(
                    color: Color(0xFF171717),
                    fontSize: 14,
                    fontWeight: FontWeight(590),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text.rich(
                  TextSpan(
                    text: AppLocalizations.of(context).menuHeaderDeliveryFree,
                    children: [
                      TextSpan(
                        text:
                            " ${AppLocalizations.of(context).menuHeaderDeliveryTime(35)}",
                        style: TextStyle(color: Color(0xFF00AB48)),
                      ),
                    ],
                    style: TextStyle(color: Color(0xAA171717), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(backgroundColor: Color(0xFFFF7AA5), radius: 18),
        ],
      ),
    );
  }
}
