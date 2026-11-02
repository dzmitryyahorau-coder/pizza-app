import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/shared/widgets/price_chip.dart';

Widget tempImg = Container(
  width: 108,
  height: 108,
  margin: EdgeInsets.only(right: 8),
  decoration: BoxDecoration(color: Colors.grey),
);

class FeaturedItem extends StatelessWidget {
  final String label;
  final String price;
  final String? image;

  const FeaturedItem({
    super.key,
    required this.label,
    required this.price,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      width: 230,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset('assets/images/brusletiki.png', width: 108, height: 108),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                PriceChip(price: price),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedList extends StatelessWidget {
  const FeaturedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.featuresSectionTitle,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 152,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: EdgeInsetsGeometry.directional(end: AppSpacing.l),
                  child: FeaturedItem(
                    label: 'Бруслетики с клюквой',
                    price: 'от 669 P',
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
