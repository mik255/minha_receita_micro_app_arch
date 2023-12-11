import 'package:flutter/material.dart';
import 'package:minha_receita/design_system/text_inputs/text_field.dart';

import '../../../../design_system/divider/divider.dart';
import '../../../../design_system/title/default_title.dart';
import '../store/recipe_store.dart';

class Steps extends StatelessWidget {
  const Steps({
    super.key,
    required this.store,
    required this.theme,
  });

  final RecipeStore store;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    var list = store.stepsController;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DSDefaultTitle(
                    title: 'Modo de Preparo',
                    leading: Icons.access_time,
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
                        Text(
                          '${list.indexOf(textController) + 1}.',
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text('${textController.text}.',
                                style: theme.textTheme.labelLarge
                                    ?.copyWith(
                                    fontWeight:
                                    FontWeight.w500))
                                .convertToInput(
                              hintText:
                              'Digite aqui o passo ${list.indexOf(textController) + 1}',
                              controller: textController,
                              onValidate: (c) {
                                return null;
                              },
                              focusNode: FocusNode(),
                            )),
                      ],
                    ),
                    const DSDivider()
                  ],
                ),
              ))
                  .toList(),
            ],
          ),
        ),
      ],
    );
  }
}