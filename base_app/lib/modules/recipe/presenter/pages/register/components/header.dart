import 'package:flutter/material.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';

import '../recipe_register_page.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({
    super.key,
    required this.data,
  });

  final PageData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48).copyWith(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: DSCustomContainer(
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              width: 100,
              height: 100,
              iconPadding: const EdgeInsets.all(8),
              iconColor: Theme.of(context).colorScheme.tertiaryContainer,
              child:  Center(
                child: Icon(
                  data.icon,
                  size: 35,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            data.title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                 fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
