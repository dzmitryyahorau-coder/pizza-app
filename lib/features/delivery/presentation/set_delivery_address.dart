import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/l10n/app_localizations.dart';
import 'package:pizza_app/shared/widgets/primary_filled_button.dart';

class SetDeliveryAddress extends StatelessWidget {
  const SetDeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context);

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
                            l.closeButton,
                            style: TextStyle(color: Color(0xFFFF6400)),
                          ),
                        ),
                      ),
                      Text(
                        l.deliveryAddresesScreenHead,
                        style: TextStyle(
                          color: colors.onSurface,
                          fontWeight: FontWeight(590),
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
                      l.addYourDeliveryAddressHead,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    Text(
                      l.addYourDeliveryAddressBody,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: 10),

                    PrimaryFilledButton(
                      onPressed: () {},
                      label: l.addAddressButton,
                    ),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        l.notNowButton,
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
