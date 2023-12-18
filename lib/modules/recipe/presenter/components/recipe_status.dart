import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/design_system/bottons/text_button.dart';
import 'package:minha_receita/design_system/modals_contents/default_modal.dart';
import 'package:minha_receita/modules/common/extensions/context.dart';
import 'package:minha_receita/modules/recipe/presenter/store/recipe_store.dart';

import '../../../../design_system/bottons/buttom.dart';
import '../../../../design_system/cards/default_dialog.dart';
import '../../../../design_system/containers/custom_container.dart';
import '../../../../design_system/divider/divider.dart';
import '../../../../design_system/text_inputs/text_field.dart';
import '../../../../design_system/title/default_title.dart';
import '../../domain/model/recipe_model.dart';

class RecipeStatusPanel extends StatefulWidget {
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
  State<RecipeStatusPanel> createState() => _RecipeStatusPanelState();
}

class _RecipeStatusPanelState extends State<RecipeStatusPanel> {
  RecipeStore get store => GetIt.I.get<RecipeStore>();

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
            InkWell(
              onTap: () {
                _timeDialog();
              },
              child: DSDefaultTitle(
                backgroundColor: Colors.transparent,
                spaceBetween: 0,
                iconSize: 16,
                style: widget.theme.textTheme.bodyMedium?.copyWith(
                  color: widget.theme.colorScheme.secondary,
                ),
                title: '${store.timeInMinutes} min',
                leading: Icons.timer,
              ),
            ),
            const DSDivider(
              type: DSDividerType.vertical,
            ),
            InkWell(
              onTap: () {
                _selectDifficulty();
              },
              child: DSDefaultTitle(
                backgroundColor: Colors.transparent,
                spaceBetween: 0,
                iconSize: 16,
                style: widget.theme.textTheme.bodyMedium?.copyWith(
                  color: widget.theme.colorScheme.secondary,
                ),
                title: store.dificulty.getName(),
                leading: Icons.restaurant,
              ),
            ),
            const DSDivider(
              type: DSDividerType.vertical,
            ),
            InkWell(
              onTap: () {
                _selectType();
              },
              child: DSDefaultTitle(
                backgroundColor: Colors.transparent,
                spaceBetween: 0,
                iconSize: 16,
                style: widget.theme.textTheme.bodyMedium?.copyWith(
                  color: widget.theme.colorScheme.secondary,
                ),
                title: store.status.getName(),
                leading: Icons.favorite,
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectDifficulty() {
    widget.context.commonExtensionsShowDSModal(
        customContent: DSModal(
            dsModalVariants: DSModalVariants.optionsModal,
            title: 'Selecione a dificuldade',
            subtitle: 'Selecione a dificuldade da sua receita',
            buttons: [
          DSCustomButton(
            type: _checkDificultButtonSelected(RecipeDificulty.facil),
            padding: const EdgeInsets.symmetric(vertical: 8),
            backgroundColor: widget.theme.colorScheme.primaryContainer,
            text: 'Fácil',
            onTap: () {
              store.setDificulty(RecipeDificulty.facil);
              Navigator.pop(context);
            },
          ),
          DSCustomButton(
            type: _checkDificultButtonSelected(RecipeDificulty.medio),
            padding: const EdgeInsets.symmetric(vertical: 8),
            backgroundColor: widget.theme.colorScheme.primaryContainer,
            text: 'Moderado',
            onTap: () {
              store.setDificulty(RecipeDificulty.medio);
              Navigator.pop(context);
            },
          ),
          DSCustomButton(
            type: _checkDificultButtonSelected(RecipeDificulty.dificil),
            padding: const EdgeInsets.symmetric(vertical: 8),
            backgroundColor: widget.theme.colorScheme.primaryContainer,
            text: 'Difícil',
            onTap: () {
              store.setDificulty(RecipeDificulty.dificil);
              Navigator.pop(context);
            },
          ),
        ]));
  }

  _checkDificultButtonSelected(RecipeDificulty dificulty) {
    if (store.dificulty == dificulty &&
        store.dificulty != RecipeDificulty.undefined) {
      return DSCustomButtonTypes.solid;
    } else {
      return DSCustomButtonTypes.outline;
    }
  }

  _selectType() {
    widget.context.commonExtensionsShowDSModal(
        customContent: DSModal(
            dsModalVariants: DSModalVariants.optionsModal,
            title: 'Selecione o Tipo',
            subtitle: 'Selecione o tipo da sua receita',
            buttons: [
          ...RecipeStatus.values
              .where((element) => element != RecipeStatus.undefined)
              .map((e) => DSCustomButton(
                    type: _checkTypeButtonSelected(e),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    backgroundColor: widget.theme.colorScheme.primaryContainer,
                    text: e.getName(),
                    onTap: () {
                      store.setStatus(e);
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ]));
  }

  _checkTypeButtonSelected(RecipeStatus status) {
    if (store.status == status &&
        store.dificulty != RecipeDificulty.undefined) {
      return DSCustomButtonTypes.solid;
    } else {
      return DSCustomButtonTypes.outline;
    }
  }

  _timeDialog(){
    showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        //center

        builder: (context){
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: DSDefaultCardDialogContent(
                  title: 'Adicione um Tempo',
                  subtitle:
                  'Adicione o tempo que você leva para fazer essa receita',
                  middleCustomContent: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        AppDSTextField(
                          controller: store.timeTextController,
                          onValidate: (value) {
                            return null;
                          },
                          hintText: 'tempo em minutos',
                        ),
                      ],
                    ),
                  ),
                  buttons: [
                    Column(
                      children: [
                        DSTextButton(
                          onPressed: () {
                            store.addTime();
                            Navigator.pop(context);
                          },
                          text: 'Adicionar',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
