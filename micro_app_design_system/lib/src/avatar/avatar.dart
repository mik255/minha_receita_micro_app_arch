import 'package:flutter/material.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import '../containers/custom_container.dart';

class DSAvatar extends StatelessWidget {
  const DSAvatar(
      {super.key,
      required this.imgUrl,
      required this.name,
      this.date,
      this.size = 30,
      this.nameBelowAvatar = false,
      this.nameStyle,
      this.namePadding});

  final String imgUrl;
  final String name;
  final DateTime? date;
  final double size;
  final bool nameBelowAvatar;
  final TextStyle? nameStyle;
  final EdgeInsetsGeometry? namePadding;

  @override
  Widget build(BuildContext context) {
    var spacer = const SizedBox(width: 8);
    var theme = Theme.of(context);
    var nameWidget = Container(
      padding: namePadding,
      child: Text(
        name,
        style: nameStyle ??
            theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
      ),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            DSCustomContainer(
              height: size,
              width: size,
              backgroundColor: Colors.grey,
              imgURL: imgUrl,
            ),
            if (nameBelowAvatar) nameWidget
          ],
        ),
        spacer,
        if (!nameBelowAvatar) nameWidget,
        spacer,
        if (date != null)
          Text(
            //'• ${date!.coreExtensionsLastTime}',
            '• ${date!.coreExtensionsLastTime}',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSecondary),
          ),
      ],
    );
  }
}
