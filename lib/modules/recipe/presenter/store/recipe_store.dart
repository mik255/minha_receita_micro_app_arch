import 'package:flutter/cupertino.dart';
import 'package:minha_receita/modules/recipe/presenter/states/ingredients_states.dart';
import '../../domain/use_case/get_recipe_by_id.dart';

class RecipeStore extends ChangeNotifier {
  final GetRecipeByIdUseCase _useCase;

  RecipeStore({required GetRecipeByIdUseCase useCase}) : _useCase = useCase;
  RecipeState state = RecipeLoadingState();

  void getRecipeById(String recipeId) async {
    state = RecipeLoadingState();
    notifyListeners();
    try {
      var recipeModel = await _useCase(recipeId);
      state = RecipeSuccessState(recipeModel: recipeModel);
      notifyListeners();
    } catch (e) {
      state = RecipeException();
      notifyListeners();
    }
  }
}
