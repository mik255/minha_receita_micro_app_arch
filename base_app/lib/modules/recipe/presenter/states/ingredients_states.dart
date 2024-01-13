import 'package:minha_receita/modules/recipe/domain/model/recipe_model.dart';

abstract class RecipeState {}

class RecipeLoadingState extends RecipeState {}

class RecipeSuccessState extends RecipeState {
  RecipeSuccessState({required this.recipeModel});

  RecipeModel recipeModel;
}

class RecipeException extends RecipeState {}
