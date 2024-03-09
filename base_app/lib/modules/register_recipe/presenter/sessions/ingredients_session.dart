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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _ingredientsCubitController,
        builder: (context, state) {
          return DSSession(
            icon: Icons.format_list_bulleted,
            title: 'Ingredientes',
            subtitle: 'Adicione ingredientes individualmente',
            isOpen: isOpen,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(builder: (context) {
                  if (state is IngredientsSuccessState) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Adicione um ingrediente',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface),
                                          ).convertToInput(
                                            controller: state.controllers[index],
                                            hintText: 'Adicione um ingrediente',
                                            onValidate: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Ingrediente não pode ser vazio';
                                              }
                                              return null;
                                            },
                                            focusNode: FocusNode(),
                                          ),
                                        ),
                                        DSChip(
                                          onTap: (){},
                                          title: 'Remover',
                                          backgroundColor: const Color(0xFFFFDFDF),
                                          titleColor: const Color(0xFFE74C3C),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        child: DSChip(
                          onTap: (){
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
  }
}
