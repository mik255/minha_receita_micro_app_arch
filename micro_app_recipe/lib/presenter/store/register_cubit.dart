import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_app_common/micro_app_common.dart';

import '../../domain/repository/recipe_repository.dart';
import '../states/ingredients_states.dart';

class RegisterRecipeCubit extends Cubit<RecipeRegisterState> {
  final RecipeRepository _registerRecipeRepository;
  TextEditingController time = TextEditingController();
  final TextEditingController description = TextEditingController();
  final List<TextEditingController> ingredients = [];
  final List<TextEditingController> preparationMethod = [];
  RecipeStatus? status;
  RecipeDificulty? dificulty;

  RegisterRecipeCubit(this._registerRecipeRepository)
      : super(RecipeRegisterInitialState());

  Future<void> registerRecipe(RecipeModel recipe) async {
    try {
      emit(RecipeRegisterLoadingState());
      await _registerRecipeRepository.postRecipe(recipe);
      emit(RecipeRegisterSuccessState());
    } on Exception {
      emit(RecipeRegisterErrorState());
    }
  }

  Future<void> addIngredients() async {
    ingredients.add(TextEditingController());
    emit(RecipeRegisterUpdateIngredientState(
      ingredients: ingredients,
    ));
  }

  Future<void> removeIngredients(TextEditingController controller) async {
    ingredients.remove(controller);
    emit(RecipeRegisterUpdateIngredientState(
      ingredients: ingredients,
    ));
  }

  Future<void> addPreparationMethod() async {
    preparationMethod.add(TextEditingController());
    emit(RecipeRegisterUpdatePreparationMethodState(
      preparationMethod: preparationMethod,
    ));
  }

  Future<void> removePreparationMethod(TextEditingController controller) async {
    preparationMethod.remove(controller);
    emit(RecipeRegisterUpdatePreparationMethodState(
      preparationMethod: preparationMethod,
    ));
  }

  Future<void> addStatus(RecipeStatus? status) async {
    this.status = status;
    emit(RecipeRegisterUpdateStatusState(
      status: this.status!,
    ));
  }

  Future<void> addDificulty(RecipeDificulty? dificulty) async {
    this.dificulty = dificulty;
    emit(RecipeRegisterUpdateDificultyState(
      dificulty: this.dificulty!,
    ));
  }
}
