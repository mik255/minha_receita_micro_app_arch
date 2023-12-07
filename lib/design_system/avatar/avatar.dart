import 'package:flutter/material.dart';
import 'package:minha_receita/core/extensions/date.dart';
import '../containers/custom_container.dart';

class DSAvatar extends StatelessWidget {
  const DSAvatar({
    super.key,
    required this.imgUrl,
    required this.name,
    this.date,
  });

  final String imgUrl;
  final String name;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    var spacer = const SizedBox(width: 8);
    var theme = Theme.of(context);
    return Row(
      children: [
        DSCustomContainer(
          height: 30,
          width: 30,
          backgroundColor: Colors.grey,
          imgURL: imgUrl,
        ),
        spacer,
        Wrap(
          children: [
            Text(
              name,
              style: theme.textTheme.bodySmall?.copyWith(
                overflow: TextOverflow.ellipsis,
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        spacer,
        if(date != null)
        Text(
          '• ${date!.coreExtensionsLastTime}',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSecondary),
        ),
      ],
    );
  }
}
