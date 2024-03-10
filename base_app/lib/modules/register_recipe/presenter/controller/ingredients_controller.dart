import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_receita/modules/register_recipe/models/ingredient.dart';
import '../../services/register_recipe_service.dart';

class IngredientsState {}

class IngredientsInitialState extends IngredientsState {}

class IngredientsSuccessState extends IngredientsState {
  final List<TextEditingController> controllers;

  IngredientsSuccessState(
    this.controllers,
  );
}

class IngredientsFailureState extends IngredientsState {
  final String message;

  IngredientsFailureState(
    this.message,
  );
}

class IngredientsCubitController extends Cubit<IngredientsState> {
  final RegisterRecipeService _service = Modular.get();

  final List<TextEditingController> _controllers = [];

  IngredientsCubitController() : super(IngredientsInitialState());


  void addIngredient() {
    _controllers.add(TextEditingController());
    _service.setIngredients(Ingredient(
      description: _controllers.last.text,
    ));
    emit(IngredientsSuccessState(
      _controllers,
    ));
  }

  void removeIngredient(int index) {
    _controllers.removeAt(index);
    _service.removeIngredients(index);
    emit(IngredientsSuccessState(
      _controllers,
    ));
  }
}
