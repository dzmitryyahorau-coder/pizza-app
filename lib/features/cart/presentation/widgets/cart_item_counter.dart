import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_colors.dart';

const double _height = 30;
const double _radius = 13;
const double _buttonWidth = 44;
const double _minValueWidth = 15;
const double _glyphSize = 14;
const double _glyphStroke = 2.8;

class CartItemCounter extends StatelessWidget {
  const CartItemCounter({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.chipBackground,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: SizedBox(
        height: _height,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CounterButton(
              onTap: onDecrement,
              child: _Glyph(color: colors.onSurface),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: _minValueWidth),
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 15,
                  height: 1,
                ),
              ),
            ),
            _CounterButton(
              onTap: onIncrement,
              child: _Glyph(color: colors.onSurface, isPlus: true),
            ),
          ],
        ),
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: _buttonWidth,
          height: _height,
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _Glyph extends StatelessWidget {
  const _Glyph({required this.color, this.isPlus = false});

  final Color color;
  final bool isPlus;

  @override
  Widget build(BuildContext context) {
    final bar = DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(_glyphStroke / 2),
      ),
    );

    return SizedBox.square(
      dimension: _glyphSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(width: _glyphSize, height: _glyphStroke, child: bar),
          if (isPlus)
            SizedBox(width: _glyphStroke, height: _glyphSize, child: bar),
        ],
      ),
    );
  }
}
