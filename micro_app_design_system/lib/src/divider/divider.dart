import 'package:flutter/material.dart';

enum DSDividerType { horizontal, vertical }

class DSDivider extends StatelessWidget {
  const DSDivider({
    super.key,
    this.type = DSDividerType.horizontal,
    this.verticalDividerHeight = 15.0,
    this.thickness = 1,
  });

  final DSDividerType type;
  final double verticalDividerHeight;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    if (type == DSDividerType.vertical) {
      return SizedBox(
        height: verticalDividerHeight,
        child: VerticalDivider(
          color: Theme.of(context).colorScheme.secondary,
          thickness: thickness,
        ),
      );
    }

    return Divider(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.04),
      thickness: thickness,
      height: 16,
    );
  }
}
