import 'package:flutter/material.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/shared/widgets/primary_filled_button.dart';

class SetDeliveryAddress extends StatelessWidget {
  const SetDeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 120,
              child: Image.asset(
                'assets/images/dodo_emptystate_eyesupd.png',
                fit: BoxFit.contain,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(AppSpacing.l),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            l10n.closeButton,
                            style: TextStyle(
                              color: context.appColors.brandColor,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        l10n.deliveryAddresesScreenHead,
                        style: TextStyle(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      l10n.addYourDeliveryAddressHead,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    Text(
                      l10n.addYourDeliveryAddressBody,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: AppSpacing.l),

                    PrimaryFilledButton(
                      onPressed: () {},
                      label: l10n.addAddressButton,
                    ),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        l10n.notNowButton,
                        style: TextStyle(color: colors.onSurface),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
