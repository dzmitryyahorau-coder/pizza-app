import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsGeometry.directional(
        start: AppSpacing.screenHorizontal,
        end: AppSpacing.screenHorizontal,
      ),
      child: Row(
        spacing: 4,
        children: [
          CircleAvatar(backgroundColor: Colors.grey, radius: 18),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Тентюковская улица, 333",
                  style: TextStyle(color: Color(0xFF171717), fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Доставка бесплатная, 35 минут",
                  style: TextStyle(color: Color(0xFF171717), fontSize: 12),
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
