import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/blured_surface.dart';

class HorizontalSelector<T> extends StatelessWidget {
  final List<T> options;
  final T selected;
  final ValueChanged<T> onSelected;
  final String Function(T option) labelBuilder;

  const HorizontalSelector({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BluredSurface(
      darkness: 0.3,
      borderRadius: BorderRadiusGeometry.circular(32),
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppSpacing.s),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            for (final option in options)
              InkWell(
                onTap: () {
                  onSelected(option);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: selected == option
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: AnimatedDefaultTextStyle(
                    style: TextStyle(
                      color: selected == option ? Colors.black : Colors.white,
                      backgroundColor: selected == option
                          ? Colors.white
                          : Colors.transparent,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    duration: Duration(milliseconds: 200),
                    child: Text(labelBuilder(option)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
