import 'package:flutter/material.dart';

class DSDivider extends StatelessWidget {
  const DSDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      thickness: 0.5,
      height: 16,
    );
  }
}
