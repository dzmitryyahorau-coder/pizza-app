import 'package:flutter/material.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/delivery/presentation/widgets/addresses_list.dart';
import 'package:pizza_app/features/delivery/presentation/widgets/new_address_form.dart';
import 'package:pizza_app/shared/widgets/primary_filled_button.dart';

class AddressesListPanelWidget extends StatefulWidget {
  const AddressesListPanelWidget({super.key});

  @override
  State<AddressesListPanelWidget> createState() => _AddressesListPanelState();
}

class _AddressesListPanelState extends State<AddressesListPanelWidget> {
  bool _isAddingMode = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF111318),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.only(
          top: AppSpacing.l,
          left: AppSpacing.xl,
          right: AppSpacing.xl,
          bottom: AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.myAddressesHead,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => setState(() {
                    _isAddingMode = true;
                  }),
                  icon: const Icon(Icons.add, color: Colors.white, size: 16),
                  label: Text(
                    l10n.newAddressButton,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF282D39),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _isAddingMode
                  ? const NewAddressForm(key: ValueKey('form'))
                  : const AddressesList(key: ValueKey('list')),
            ),

            const SizedBox(height: AppSpacing.xl),

            Padding(
              padding: EdgeInsetsGeometry.directional(bottom: AppSpacing.l),
              child: PrimaryFilledButton(
                onPressed: () {},
                label: l10n.orderHereButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
