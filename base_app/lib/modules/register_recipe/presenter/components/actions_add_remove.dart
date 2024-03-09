import 'package:flutter/material.dart';

import 'ds_chip.dart';

class ActionsAddRemove extends StatelessWidget {
  const ActionsAddRemove({
    super.key,
    required this.onAdd,
    required this.onRemove,
  });

  final Function() onAdd;
  final Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          DSChip(
            onTap: onAdd,
            title: 'Adicionar',
            backgroundColor: const Color(0xFFFFF1DF),
            titleColor: const Color(0xFFFF9811),
          ),
          const SizedBox(
            width: 16,
          ),
          DSChip(
            onTap: onRemove,
            title: 'Remover',
            backgroundColor: const Color(0xFFFFDFDF),
            titleColor: const Color(0xFFE74C3C),
          )
        ],
      ),
    );
  }
}
