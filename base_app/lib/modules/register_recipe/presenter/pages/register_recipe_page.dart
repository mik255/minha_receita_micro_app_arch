import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import '../controller/register_recipe_controller.dart';
import '../sessions/info_session.dart';
import '../sessions/ingredients_session.dart';
import '../sessions/method_of_preparation_session.dart';
import '../sessions/name_session.dart';
import '../sessions/photos_session.dart';

class RegisterRecipe extends StatelessWidget {
  RegisterRecipe({super.key});

  final RegisterRecipeController _registerRecipeController =
      RegisterRecipeController();

  @override
  Widget build(BuildContext context) {
    return AppDSBasePage(
      withScroll: false,
      appDSAppBar: AppDSAppBar(
        type: AppDSBarType.variant1,
        title: 'Cadastro',
        actions: [
          InkWell(
            onTap: () {
              _registerRecipeController.saveRecipe();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Salvar',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: BlocBuilder(
            bloc: _registerRecipeController,
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const PhotoSession(),
                        const DSDivider(thickness: 2),
                        InfoSession(),
                        const DSDivider(thickness: 2),
                        NameAndDescriptionSession(),
                        const DSDivider(thickness: 2),
                        IngredientSession(),
                        const DSDivider(thickness: 2),
                        const MethodOfPreparationSession(),
                      ],
                    ),
                  ),
                  if (state is RegisterRecipeLoadingState)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  if (state is RegisterRecipeLoadingState)
                    const Center(
                        child: SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3,
                      ),
                    )),
                ],
              );
            }),
      ),
    );
  }
}
