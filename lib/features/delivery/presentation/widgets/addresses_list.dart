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
    final colors = context.appColors;

    return Column(
      children: [
        for (final (i, address) in list.indexed)
          _buildAddressItem(
            selectedColor: colors.brandColor,
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

Widget _buildAddressItem({
  required Color selectedColor,
  required String title,
  required String subtitle,
  required bool isSelected,
  required bool isLast,
  required VoidCallback onSelect,
}) {
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
                  color: isSelected ? selectedColor : const Color(0xFF3E4351),
                  shape: BoxShape.circle,
                ),
                child: isSelected
                    ? const Center(
                        child: Icon(
                          Icons.circle,
                          color: Colors.white,
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      if (!isLast) const Divider(color: Colors.white12, height: 1),
    ],
  );
}
