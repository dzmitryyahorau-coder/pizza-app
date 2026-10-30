import 'package:flutter/material.dart';
import 'package:pizza_app/features/product_details/data/dough.dart';

class DoughButton extends StatelessWidget {
  const DoughButton({
    super.key,
    required this.dough,
    required this.isActive,
    required this.onPress,
  });

  final Dough dough;
  final bool isActive;
  final VoidCallback onPress;

  static const double _plateHeight = 56;
  static const double _overhang = 20;
  static const double _imageHeight = 40;
  static const double _imageWidth = 66;
  static const Duration _duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isActive,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPress,
        child: SizedBox(
          height: _plateHeight + _overhang,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: _plateHeight,
                child: AnimatedContainer(
                  duration: _duration,
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.white
                        : Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(_plateHeight / 2),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  dough.imageAsset,
                  width: _imageWidth,
                  height: _imageHeight,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: 8,
                right: 8,
                bottom: 17,
                child: AnimatedDefaultTextStyle(
                  duration: _duration,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isActive ? Colors.black : Colors.white,
                  ),
                  child: Text(dough.name),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
