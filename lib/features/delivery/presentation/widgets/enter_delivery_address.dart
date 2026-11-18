import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/delivery/data/models/address.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_cubit.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_state.dart';

class EnterDeliveryAddress extends StatelessWidget {
  const EnterDeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.appColors;

    return BlocSelector<AddressesCubit, AddressesState, Address?>(
      selector: (state) => state.selectedAddress,
      builder: (context, address) => InkWell(
        onTap: () => context.push('/addresses-list'),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
              child: SvgPicture.asset(
                'assets/icons/m_courier.svg',
                width: 12,
                height: 21,
              ),
            ),
            Expanded(
              child: Text(
                address?.fullAddress ?? l10n.cartEnterDeliveryAddress,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.l),
              child: Icon(
                Icons.chevron_right,
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
