import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

class CustomizeButton extends StatelessWidget {
  final void Function() onPressed;

  const CustomizeButton({super.key, required this.onPressed});

  static const List<String> images = [
    'assets/images/jalapenos.png',
    'assets/images/bacon.png',
    'assets/images/cheese.png',
  ];

  static const double _step = 17;
  static const double _circle = 24;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        spacing: AppSpacing.m,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 24,
            width: 75,
            child: Stack(
              children: [
                for (int i = 0; i < images.length; i++)
                  Positioned(
                    left: (i + 1) * _step,
                    child: Container(
                      width: _circle,
                      height: _circle,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.3),
                      ),
                      child: Image.asset(images[i], width: 20),
                    ),
                  ),
              ],
            ),
          ),
          Text(
            AppLocalizations.of(context).productCustomizationButtonLabel,
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
