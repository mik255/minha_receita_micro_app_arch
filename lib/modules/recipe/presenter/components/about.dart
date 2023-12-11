import 'package:flutter/material.dart';
import 'package:minha_receita/design_system/text_inputs/text_field.dart';

import '../../../../design_system/title/default_title.dart';
import '../../domain/model/recipe_model.dart';
import '../store/recipe_store.dart';

class About extends StatelessWidget {
  const About({
    super.key,
    required this.theme,
    required this.store,
    required this.model,
  });

  final ThemeData theme;
  final RecipeStore store;
  final RecipeModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 16),
      child: DSDefaultTitle(
          backgroundColor: Colors.transparent,
          spaceBetween: 0,
          iconSize: 16,
          title: 'Sobre a receita',
          description: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              model.description ?? 'null',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ).convertToInput(
              hintText: 'Digite aqui e fale um pouco sobre a sua receita',
              focusNode: FocusNode(),
              controller: store.descriptionController,
              onValidate: (value) {
                return null;
              },
            ),
          )),
    );
  }

}
