import 'package:flutter/material.dart';

import '../tokens/colors/colors.dart';

class AppDSCardDefault extends StatelessWidget {
  const AppDSCardDefault({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius = 10,
    this.elevation = 10,
  });

  final Widget child;
  final Color? backgroundColor;
  final double borderRadius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor ?? AppDSColors.white,
          boxShadow: [
            if (elevation > 0)
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              )
          ]),
      child: child,
    );
  }
}
