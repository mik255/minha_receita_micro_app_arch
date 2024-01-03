import 'package:flutter/material.dart';

import '../containers/custom_container.dart';
import '../icon/close_icon.dart';

class DSDefaultCardDialogContent extends StatelessWidget {
  const DSDefaultCardDialogContent({
    super.key,
    this.title,
    this.subtitle,
    this.middleCustomContent,
    this.buttons = const [],
    this.buttonAxis = Axis.vertical,
    this.alignCenter = false,
    this.closeIcon = false,
  });

  final String? title;
  final String? subtitle;
  final Widget? middleCustomContent;
  final List<Widget> buttons;
  final Axis buttonAxis;
  final bool alignCenter;
  final bool closeIcon;

  @override
  Widget build(BuildContext context) {
    var space = const SizedBox(height: 16);
    var buttonsList = <Widget>[];
    if (buttons.isNotEmpty) {
       buttonsList = buttons
          .map((e) => Row(
                children: [
                  Expanded(child: e),
                ],
              ))
          .toList();
    }

    return DSCustomContainer(
      shadows: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              alignCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: alignCenter
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            if (closeIcon) DSCloseIcon(context: context),
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
            if (buttonAxis == Axis.horizontal)
              Row(
                mainAxisAlignment: alignCenter
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: alignCenter
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: buttonsList,
              )
            else if (buttonAxis == Axis.vertical)
              Column(
                mainAxisAlignment: alignCenter
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: alignCenter
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: buttonsList,
              )
          ],
        ),
      ),
    );
  }
}
