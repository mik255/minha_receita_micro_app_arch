import 'package:flutter/material.dart';
import 'package:minha_receita/design_system/cards/default_dialog.dart';

import '../icon/close_icon.dart';

enum DSModalVariants {
  defaultModal,
  optionsModal,
}
class DSModal extends StatelessWidget {
  const DSModal({
    super.key,
    this.content,
    this.withScroll = true,
    this.title,
    this.subtitle,
    this.buttons,
    this.dsModalVariants = DSModalVariants.defaultModal,
  });

  final Widget? content;
  final bool withScroll;
  final String? title;
  final String? subtitle;
  final List<Widget>? buttons;
  final DSModalVariants dsModalVariants;
  @override
  Widget build(BuildContext context) {
    if(dsModalVariants == DSModalVariants.optionsModal){
      return DSDefaultCardDialogContent(
        closeIcon: true,
        title: title,
        alignCenter: true,
        subtitle: subtitle,
        middleCustomContent: content,
        buttons: buttons??[],
        buttonAxis: Axis.vertical,
      );
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.background,
      ),
      child: modalContent(context,content)
    );
  }

  Widget modalContent(BuildContext context,Widget? content){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DSCloseIcon(context: context),
        const SizedBox(height: 16),
        if (withScroll)
          Expanded(
            child: SingleChildScrollView(
              child: content,
            ),
          )
        else
          content??Container(),
      ],
    );
  }
}


