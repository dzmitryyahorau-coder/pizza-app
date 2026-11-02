import 'package:flutter/material.dart';
import 'package:pizza_app/core/l10n_x.dart';

class ShowMoreButton extends StatelessWidget {
  const ShowMoreButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Text(
            context.l10n.showAllLabel,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.white),
        ],
      ),
    );
  }
}
