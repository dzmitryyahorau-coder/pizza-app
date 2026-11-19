import 'package:flutter/material.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/delivery/data/models/address.dart';

class AddressesList extends StatelessWidget {
  const AddressesList({
    super.key,
    required this.list,
    required this.onSelectAddress,
    this.selectedAddressId,
  });

  final List<Address> list;
  final String? selectedAddressId;
  final void Function(String) onSelectAddress;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        for (final (i, address) in list.indexed)
          _AddressItem(
            title: switch (address.label) {
              AddressLabel.home => l10n.addressLabelHome,
              AddressLabel.work => l10n.addressLabelWork,
              AddressLabel.other => l10n.addressLabelOther,
            },
            subtitle: address.fullAddress,
            isSelected: selectedAddressId == address.id,
            isLast: i == list.length - 1,
            onSelect: () => onSelectAddress(address.id!),
          ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

class _AddressItem extends StatelessWidget {
  const _AddressItem({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.isLast,
    required this.onSelect,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final bool isLast;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      children: [
        InkWell(
          onTap: onSelect,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.brandColor
                        : colors.onSurfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: isSelected
                      ? Center(
                          child: Icon(
                            Icons.circle,
                            color: colors.onSurface,
                            size: 10,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: colors.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: colors.onSurfaceVariant,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: colors.onSurfaceVariant),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(color: colors.onSurface.withValues(alpha: 0.12), height: 1),
      ],
    );
  }
}
