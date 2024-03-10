import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/modules/register_recipe/models/ingredient.dart';
import 'package:minha_receita/modules/register_recipe/presenter/components/ds_session.dart';

import '../components/actions_add_remove.dart';
import '../components/add_button.dart';
import '../components/ds_chip.dart';
import '../controller/ingredients_controller.dart';

class IngredientSession extends StatelessWidget {
  IngredientSession({super.key});

  final IngredientsCubitController _ingredientsCubitController =
      IngredientsCubitController();

  ValueNotifier<bool> isOpen = ValueNotifier(false);
  final height = ValueNotifier(80.0);
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _ingredientsCubitController,
        builder: (context, state) {
          return AnimatedBuilder(
              animation: height,
              builder: (context, heightState) {
                return DSSession(
                  icon: Icons.format_list_bulleted,
                  title: 'Ingredientes',
                  subtitle: 'Adicione ingredientes individualmente',
                  height: () {
                    if (state == null || state is IngredientsInitialState) {
                      return 80.0;
                    }
                    state as IngredientsSuccessState;
                    if (state.controllers.isEmpty) {
                      return 80.0;
                    }
                    if (globalKey.currentContext == null) {
                      return 145.0;
                    }
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      Future.delayed(const Duration(milliseconds: 300), () {
                        height.value = globalKey.currentContext!.size!.height;
                      });
                    });
                    return height.value;
                  }(),
                  isOpen: isOpen,
                  content: Column(
                    key: globalKey,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(builder: (context) {
                        if (state is IngredientsSuccessState) {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: List.generate(
                                  state.controllers.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8),
                                    child: Container(
                                      height: 65,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x38D9D9D9),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Adicione um ingrediente',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface),
                                                ).convertToInput(
                                                  controller:
                                                      state.controllers[index],
                                                  hintText:
                                                      'Adicione um ingrediente',
                                                  onValidate: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Ingrediente não pode ser vazio';
                                                    }
                                                    return null;
                                                  },
                                                  focusNode: FocusNode(),
                                                ),
                                              ),
                                              DSChip(
                                                onTap: () {
                                                  _ingredientsCubitController
                                                      .removeIngredient(index);
                                                },
                                                title: 'Remover',
                                                backgroundColor:
                                                    const Color(0xFFFFDFDF),
                                                titleColor:
                                                    const Color(0xFFE74C3C),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        }
                        return const SizedBox();
                      }),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 16.0),
                              child: DSChip(
                                onTap: () {
                                  _ingredientsCubitController.addIngredient();
                                },
                                title: 'Adicionar',
                                backgroundColor: const Color(0xFFFFF1DF),
                                titleColor: const Color(0xFFFF9811),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
