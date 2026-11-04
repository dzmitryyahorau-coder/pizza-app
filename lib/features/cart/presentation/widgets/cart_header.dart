import 'package:flutter/material.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/shared/widgets/custom_icon_button.dart';
import 'package:pizza_app/shared/widgets/custom_text_button.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButton(onPressed: () {}, text: context.l10n.closeButton),
        CustomIconButton(icon: Icons.delete, onPressed: () {}),
      ],
    );
  }
}
