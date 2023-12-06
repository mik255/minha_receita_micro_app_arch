import 'package:flutter/material.dart';
import '../model/recipe_model.dart';
import '../services/recipe_repository.dart';
import 'package:logger/logger.dart';
class RecipeState extends ChangeNotifier {
  bool isLoading = false;
  String? errorMsg;
  Map<String, List<RecipeModel>> recipeList = {
    'pop': [],
    'news': [],
    'favorites': [],
  };

  Future<void> getData() async {
    errorMsg = null;
    isLoading = true;
    notifyListeners();
    try {
      final getRecipeService = GetRecipeService();
      var result = await Future.wait([
        getRecipeService.call(queryType: RecipeType.pop),
        getRecipeService.call(queryType: RecipeType.newRecipe),
        getRecipeService.call(queryType: RecipeType.favorites),
      ]);
      recipeList = {
        'pop': result[0],
        'news': result[1],
        'favorites': result[2],
      };
      isLoading = false;
      notifyListeners();
    } catch (e,_) {
      Logger().e(_);
      errorMsg = 'Serviço indisponível';
      notifyListeners();
    }
  }
}
