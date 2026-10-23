import 'package:flutter/material.dart';
import 'package:pizza_app/l10n/app_localizations.dart';

Widget tempImg = Container(
  width: 108,
  height: 108,
  margin: EdgeInsets.only(right: 8),
  decoration: BoxDecoration(color: Colors.grey),
);

class FeaturedItem extends StatelessWidget {
  final String label;
  final String price;

  const FeaturedItem({super.key, required this.label, required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      width: 230,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          tempImg,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight(500)),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Chip(
                  label: Text(price),
                  backgroundColor: Colors.grey.shade200,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                ),
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
          AppLocalizations.of(context).featuresSectionTitle,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight(700)),
        ),
        SizedBox(
          height: 152,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (int i = 0; i < 5; i++)
                FeaturedItem(label: 'Бруслетики с клюквой', price: 'от 669 P'),
            ],
          ),
        ),
      ],
    );
  }
}
