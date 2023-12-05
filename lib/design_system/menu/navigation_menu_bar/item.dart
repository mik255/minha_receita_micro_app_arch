import 'package:flutter/material.dart';

import '../../containers/custom_container.dart';

class DSNavigationMenuBarItem extends StatelessWidget {
  const DSNavigationMenuBarItem({
    super.key,
    required this.customContainer,
    this.subtitle,
    this.width,
    this.height,

  });

  final String? subtitle;
  final DSCustomContainer customContainer;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 4.0,
            ),
            child: customContainer,
          ),
          if (subtitle != null)
            Wrap(
              children: [
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      //overflow: TextOverflow.ellipsis,
                      ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
