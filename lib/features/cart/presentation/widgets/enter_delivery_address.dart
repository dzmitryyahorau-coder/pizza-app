import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';

class EnterDeliveryAddress extends StatelessWidget {
  const EnterDeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.appColors;

    return InkWell(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: AppSpacing.l),
            child: SvgPicture.asset(
              'assets/icons/m_courier.svg',
              width: 12,
              height: 21,
            ),
          ),
          Text(
            l10n.cartEnterDeliveryAddress,
            style: TextStyle(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsetsGeometry.only(right: AppSpacing.l),
            child: Icon(
              Icons.chevron_right,
              color: colors.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
