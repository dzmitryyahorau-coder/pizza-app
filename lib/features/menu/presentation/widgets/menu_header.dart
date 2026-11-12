import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/shared/auth/bloc/auth_cubit.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsetsGeometry.directional(
        start: AppSpacing.l,
        end: AppSpacing.l,
      ),
      child: Row(
        spacing: 4,
        children: [
          CircleAvatar(
            backgroundColor: context.appColors.surface,
            radius: 18,
            child: SvgPicture.asset(
              'assets/icons/m_courier.svg',
              width: 20,
              height: 20,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Тентюковская улица, 333",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight(590)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text.rich(
                  TextSpan(
                    text: l10n.menuHeaderDeliveryFree,
                    children: [
                      TextSpan(
                        text: " ${l10n.menuHeaderDeliveryTime(35)}",
                        style: TextStyle(color: context.appColors.accentGreen),
                      ),
                    ],
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: SvgPicture.asset(
              'assets/icons/avatar.svg',
              width: 36,
              height: 36,
            ),
            onTap: () => context.read<AuthCubit>().logout(),
          ),
        ],
      ),
    );
  }
}
