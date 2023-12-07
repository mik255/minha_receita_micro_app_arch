import 'package:flutter/cupertino.dart';
import 'package:minha_receita/modules/recipe/presenter/states/ingredients_states.dart';
import '../../data/repository/recipe_repository.dart';

class RecipeStore extends ChangeNotifier {
  RecipeState state = RecipeLoadingState();
  final RecipeRepository _repository;

  RecipeStore({required RecipeRepository repository})
      : _repository = repository;

  void getRecipeById(String recipeId) async {
    state = RecipeLoadingState();
    notifyListeners();
    try {
      var recipeModel = await _repository.getById('recipeId');
      state = RecipeSuccessState(recipeModel: recipeModel);
      notifyListeners();
    } catch (e) {
      state = RecipeException();
      notifyListeners();
    }
  }
}
