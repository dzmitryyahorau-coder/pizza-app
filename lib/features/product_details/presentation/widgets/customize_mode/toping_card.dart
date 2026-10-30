import 'package:flutter/material.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

class TopingCard extends StatelessWidget {
  final String title;
  final int weight;
  final double price;
  final String imgPath;

  const TopingCard({
    super.key,
    required this.title,
    required this.weight,
    required this.price,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return SizedBox(
      width: 114,
      height: 166,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            SizedBox(width: 66, height: 66, child: Image.asset(imgPath)),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight(590),
              ),
            ),
            Text(
              l.itemWeightInGrams(weight),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            Spacer(),
            Text(
              l.productPrice(price),
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
