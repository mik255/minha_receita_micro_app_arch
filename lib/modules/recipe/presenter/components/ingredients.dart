import 'package:flutter/material.dart';
import 'package:minha_receita/design_system/text_inputs/text_field.dart';

import '../../../../design_system/divider/divider.dart';
import '../../../../design_system/title/default_title.dart';
import '../store/recipe_store.dart';

class Ingredients extends StatelessWidget {
  const Ingredients({
    super.key,
    required this.store,
    required this.theme,
  });

  final RecipeStore store;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    var list = store.ingredientsController;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DSDefaultTitle(
                title: 'Ingredientes',
                leading: Icons.shopping_bag,
                iconColor: theme.colorScheme.tertiary),
          ),
          const SizedBox(
            height: 12,
          ),
          ...list
              .map((textController) => Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text('${textController.text}.',
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500))
                                    .convertToInput(
                              hintText:
                                  'Digite aqui a quantidade e o nome do ingrediente',
                              controller: textController,
                              onValidate: (c) {
                                return null;
                              },
                              focusNode: FocusNode(),
                            )),
                            Icon(
                              Icons.remove_circle_outline,
                              color: theme.colorScheme.error,
                              size: 18,
                            )
                          ],
                        ),
                        const DSDivider()
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
