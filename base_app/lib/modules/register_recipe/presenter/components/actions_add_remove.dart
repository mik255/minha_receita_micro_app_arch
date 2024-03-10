import 'package:flutter/material.dart';

import 'ds_chip.dart';

class ActionsAddRemove extends StatelessWidget {
  const ActionsAddRemove({
    super.key,
    required this.onAdd,
    required this.onRemove,
    this.addTitle = 'Adicionar',
    this.removeTitle = 'Remover',
  });

  final Function() onAdd;
  final Function() onRemove;

  final String addTitle;
  final String removeTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          DSChip(
            onTap: onAdd,
            title: addTitle,
            backgroundColor: const Color(0xFFFFF1DF),
            titleColor: const Color(0xFFFF9811),
          ),
          const SizedBox(
            width: 16,
          ),
          DSChip(
            onTap: onRemove,
            title: removeTitle,
            backgroundColor: const Color(0xFFFFDFDF),
            titleColor: const Color(0xFFE74C3C),
          )
        ],
      ),
    );
  }
}
