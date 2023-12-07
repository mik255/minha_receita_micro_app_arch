import '../model/recipe_model.dart';

abstract class RecipeRepository {
  Future<RecipeModel> getById(String recipeId);
}
