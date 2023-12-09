import 'package:flutter/material.dart';

enum DSDividerType { horizontal, vertical }

class DSDivider extends StatelessWidget {
  const DSDivider({
    super.key,
    this.type = DSDividerType.horizontal,
    this.verticalDividerHeight = 15.0,
  });

  final DSDividerType type;
  final double verticalDividerHeight;

  @override
  Widget build(BuildContext context) {
    if (type == DSDividerType.vertical) {
      return SizedBox(
        height: verticalDividerHeight,
        child: VerticalDivider(
          color: Theme.of(context).colorScheme.secondary,
          thickness: 1,
        ),
      );
    }

    return Divider(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      thickness: 0.5,
      height: 16,
    );
  }
}
