import 'package:flutter/material.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/modules/register_recipe/models/recipe_model.dart';
import '../components/ds_chip.dart';
import '../components/ds_session.dart';
import '../controller/info_controller.dart';

class InfoSession extends StatefulWidget {
  InfoSession({super.key});

  @override
  State<InfoSession> createState() => _InfoSessionState();
}

class _InfoSessionState extends State<InfoSession> {
  RecipeDificulty dificulty = RecipeDificulty.undefined;

  int timeInMinutes = 0;

  final InfoController _infoController = InfoController();

  @override
  Widget build(BuildContext context) {
    return DSSession(
      icon: Icons.info_outline,
      title: 'Informações',
      subtitle: 'Adicione informações sobre a sua receita',
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              // direction: Axis.horizontal,
              // spacing: 16,
              // runSpacing: 16,
              // crossAxisAlignment: WrapCrossAlignment.center,
              // runAlignment: WrapAlignment.start,
              // verticalDirection: VerticalDirection.down,
              // alignment: WrapAlignment.start,
              children: [
                DSChip(
                    icon: Icons.access_time,
                    title: '$timeInMinutes mim',
                    onTap: () {
                      _timeDialog();
                    }),
                const SizedBox(
                  width: 16,
                ),
                DSChip(
                    icon: Icons.restaurant,
                    title: dificulty.getName(),
                    onTap: () {
                      _selectDifficulty(context);
                    }),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            DSChip(
                icon: Icons.favorite_border,
                title: status.getName(),
                onTap: () {
                  _selectType(context);
                }),
          ],
        ),
      ),
    );
  }

  _checkDificultButtonSelected(RecipeDificulty dificulty) {
    if (this.dificulty == RecipeDificulty.undefined) {
      return DSCustomButtonTypes.outline;
    }
    if (this.dificulty == dificulty) {
      return DSCustomButtonTypes.solid;
    } else {
      return DSCustomButtonTypes.outline;
    }
  }

  _selectDifficulty(BuildContext context) {
    context.commonExtensionsShowDSModal(
        customContent: DSModal(
      dsModalVariants: DSModalVariants.optionsModal,
      title: 'Selecione a dificuldade',
      subtitle: 'Selecione a dificuldade da sua receita',
      buttons: [
        DSCustomButton(
          type: _checkDificultButtonSelected(RecipeDificulty.facil),
          padding: const EdgeInsets.symmetric(vertical: 8),
          text: 'Fácil',
          onTap: () {
            dificulty = (RecipeDificulty.facil);
            _infoController.setDifficulty(dificulty);
            Navigator.pop(context);
            setState(() {});
          },
        ),
        DSCustomButton(
          type: _checkDificultButtonSelected(RecipeDificulty.medio),
          padding: const EdgeInsets.symmetric(vertical: 8),
          text: 'Moderado',
          onTap: () {
            dificulty = RecipeDificulty.medio;
            _infoController.setDifficulty(dificulty);
            Navigator.pop(context);
            setState(() {});
          },
        ),
        DSCustomButton(
          type: _checkDificultButtonSelected(RecipeDificulty.dificil),
          padding: const EdgeInsets.symmetric(vertical: 8),
          text: 'Difícil',
          onTap: () {
            dificulty = RecipeDificulty.dificil;
            _infoController.setDifficulty(dificulty);
            Navigator.pop(context);
            setState(() {});
          },
        ),
      ],
    ));
  }

  TextEditingController timeTextController = TextEditingController();

  _timeDialog() {
    showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (context) {
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
                              controller: timeTextController,
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
                                timeInMinutes =
                                    timeTextController.text.isNotEmpty
                                        ? int.parse(timeTextController.text)
                                        : 0;
                                Navigator.pop(context);
                                _infoController.setTime(timeInMinutes);
                                setState(() {});
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

  RecipeStatus status = RecipeStatus.undefined;

  _selectType(BuildContext context) {
    checkTypeButtonSelected(RecipeStatus status) {
      if (this.status == RecipeStatus.undefined) {
        return DSCustomButtonTypes.outline;
      }
      if (this.status == status) {
        return DSCustomButtonTypes.solid;
      } else {
        return DSCustomButtonTypes.outline;
      }
    }

    context.commonExtensionsShowDSModal(
        customContent: DSModal(
            dsModalVariants: DSModalVariants.optionsModal,
            title: 'Selecione o Tipo',
            subtitle: 'Selecione o tipo da sua receita',
            buttons: [
          ...RecipeStatus.values
              .where((element) => element != RecipeStatus.undefined)
              .map((e) => DSCustomButton(
                    type: checkTypeButtonSelected(e),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    text: e.getName(),
                    onTap: () {
                      status = e;
                      _infoController.setStatus(status);
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ))
              .toList(),
        ]));
  }
}
