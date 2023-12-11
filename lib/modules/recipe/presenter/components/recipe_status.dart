import 'package:flutter/material.dart';
import 'package:minha_receita/design_system/bottons/text_button.dart';
import 'package:minha_receita/design_system/modals_contents/default_modal.dart';
import 'package:minha_receita/modules/common/extensions/context.dart';

import '../../../../design_system/bottons/buttom.dart';
import '../../../../design_system/cards/default_dialog.dart';
import '../../../../design_system/containers/custom_container.dart';
import '../../../../design_system/divider/divider.dart';
import '../../../../design_system/title/default_title.dart';
import '../../domain/model/recipe_model.dart';

class RecipeStatusPanel extends StatelessWidget {
  const RecipeStatusPanel({
    super.key,
    required this.context,
    required this.theme,
    required this.model,
  });

  final BuildContext context;
  final ThemeData theme;
  final RecipeModel model;

  @override
  Widget build(BuildContext context) {
    return DSCustomContainer(
      backgroundColor: Colors.transparent,
      descriptionPadding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.9,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DSDefaultTitle(
              backgroundColor: Colors.transparent,
              spaceBetween: 0,
              iconSize: 16,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
              title: '${model.timeInMinutes} min',
              leading: Icons.timer,
            ),
            const DSDivider(
              type: DSDividerType.vertical,
            ),
            InkWell(
              onTap: (){
                _selectDifficulty();
              },
              child: DSDefaultTitle(
                backgroundColor: Colors.transparent,
                spaceBetween: 0,
                iconSize: 16,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
                title: model.difficulty,
                leading: Icons.restaurant,
              ),
            ),
            const DSDivider(
              type: DSDividerType.vertical,
            ),
            DSDefaultTitle(
              backgroundColor: Colors.transparent,
              spaceBetween: 0,
              iconSize: 16,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.secondary,
              ),
              title: model.status,
              leading: Icons.favorite,
            )
          ],
        ),
      ),
    );
  }
  _selectDifficulty() {
    context.commonExtensionsShowDSModal(
      customContent: DSModal(
          dsModalVariants: DSModalVariants.optionsModal,
          title: 'Selecione a dificuldade',
          subtitle: 'Selecione a dificuldade da sua receita',
          buttons: [
            DSCustomButton(
              padding: const EdgeInsets.symmetric(vertical: 8),
              backgroundColor: theme.colorScheme.primaryContainer,
              text: 'Fácil',
              onTap: () {},
            ),
            DSCustomButton(
              type: DSCustomButtonTypes.outline,
              padding: const EdgeInsets.symmetric(vertical: 8),
              backgroundColor: theme.colorScheme.primaryContainer,
              text: 'Moderado',
              onTap: () {},
            ),
            DSCustomButton(
              type: DSCustomButtonTypes.outline,
              padding: const EdgeInsets.symmetric(vertical: 8),
              backgroundColor: theme.colorScheme.primaryContainer,
              text: 'Difícil',
              onTap: () {},
            ),
          ]
      )
    );
  }
}