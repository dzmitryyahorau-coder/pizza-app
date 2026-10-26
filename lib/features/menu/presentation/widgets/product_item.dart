import 'package:flutter/material.dart';
import 'package:pizza_app/features/menu/data/product.dart';
import 'package:pizza_app/shared/widgets/price_chip.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: ValueKey(product.id),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.directional(end: 5),
          child: Image.asset(
            'assets/images/pizza.png',
            width: 108,
            height: 108,
          ),
        ),
        SizedBox(
          width: 192,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight(700), fontSize: 16),
                maxLines: 2,
              ),
              Text(
                product.description,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                  fontWeight: FontWeight(400),
                ),
                maxLines: 5,
              ),
              PriceChip(price: product.price.toString()),
            ],
          ),
        ),
      ],
    );
  }
}
