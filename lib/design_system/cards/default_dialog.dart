import 'package:flutter/material.dart';
import 'package:minha_receita/design_system/containers/custom_container.dart';

import '../bottons/buttom.dart';

class DSDefaultCardDialogContent extends StatelessWidget {
  const DSDefaultCardDialogContent({
    super.key,
    this.title,
    this.subtitle,
    this.middleCustomContent,
    this.buttons = const [],
  });

  final String? title;
  final String? subtitle;
  final Widget? middleCustomContent;
  final List<AppDSButtom> buttons;

  @override
  Widget build(BuildContext context) {
    var space = const SizedBox(height: 16);
    return DSCustomContainer(
      shadows: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            space,
            Text(
              subtitle ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            middleCustomContent ?? Container(),
            space,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buttons.map((e) => Expanded(child: e)).toList(),
            )
          ],
        ),
      ),
    );
  }
}
