import 'package:flutter/material.dart';
import 'package:pizza_app/features/product_details/presentation/widgets/common/blured_surface.dart';

class CloseIconButton extends StatelessWidget {
  final void Function() onPress;

  const CloseIconButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: BluredSurface(
        darkness: 0.3,
        borderRadius: BorderRadiusGeometry.circular(22),
        child: IconButton(
          onPressed: onPress,
          icon: Icon(Icons.close, color: Colors.white),
        ),
      ),
    );
  }
}
