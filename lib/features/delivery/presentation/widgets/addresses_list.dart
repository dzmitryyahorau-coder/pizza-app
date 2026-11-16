import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_colors.dart';

class AddressesList extends StatelessWidget {
  const AddressesList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Column(
      children: [
        _buildAddressItem(
          iconColor: colors.brandColor,
          title: 'Home',
          subtitle: 'Минск, Белорусская улица, 21',
          isSelected: true,
        ),
        const Divider(color: Colors.white12, height: 1), // Разделитель
        _buildAddressItem(
          iconColor: const Color(0xFF3E4351),
          title: 'Work',
          subtitle: 'Минск, улица Смолячкова, 16',
          isSelected: false,
        ),
      ],
    );
  }
}

Widget _buildAddressItem({
  required Color iconColor,
  required String title,
  required String subtitle,
  required bool isSelected,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
          child: isSelected
              ? const Center(
                  child: Icon(Icons.circle, color: Colors.white, size: 10),
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
  );
}
