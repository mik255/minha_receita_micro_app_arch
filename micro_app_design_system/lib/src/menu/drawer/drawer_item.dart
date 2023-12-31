import 'package:flutter/material.dart';
import 'package:micro_app_design_system/src/divider/divider.dart';


class DSDrawerMenuItem extends StatelessWidget {
  const DSDrawerMenuItem({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  )),
          onTap: onTap,
        ),
        const DSDivider()
      ],
    );
  }
}
