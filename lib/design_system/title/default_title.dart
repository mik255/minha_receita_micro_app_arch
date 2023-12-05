import 'package:flutter/material.dart';

import '../containers/custom_container.dart';

class DSDefaultTitle extends StatelessWidget {
  const DSDefaultTitle({
    super.key,
    this.leading,
    this.leadingText,
    required this.title,
    this.description,
    this.iconSize,
    this.style,
    this.backgroundColor,
    this.spaceBetween,
    this.iconColor,
    this.leadingBorderRadius,
  });

  final IconData? leading;
  final String title;
  final String? leadingText;
  final Widget? description;
  final double? iconSize;
  final TextStyle? style;
  final Color? backgroundColor;
  final double? spaceBetween;
  final Color? iconColor;
  final double? leadingBorderRadius;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if(leading != null || leadingText != null)
            DSCustomContainer(
              height: 32,
              width: 32,
              circularRadius: leadingBorderRadius,
              leadingText: leadingText,
              iconData: leading,
              iconColor:  iconColor??Theme.of(context).colorScheme.secondary,
              backgroundColor: backgroundColor??Theme.of(context).primaryColor,
            ),
            if(leading != null || leadingText != null)
             SizedBox(
              width: spaceBetween??10,
            ),
            Text(
              title,
              style: style??Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        description ?? Container(),
      ],
    );
  }
}
