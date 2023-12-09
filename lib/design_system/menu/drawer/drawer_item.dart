import 'package:flutter/material.dart';
import 'package:minha_receita/design_system/divider/divider.dart';

class DSDrawerMenuItem extends StatelessWidget {
  const DSDrawerMenuItem({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const DSDivider()
      ],
    );
  }
}
