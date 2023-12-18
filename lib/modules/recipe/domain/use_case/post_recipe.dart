

import '../model/recipe_model.dart';
import '../repository/recipe_repository.dart';

abstract class PostRecipeUseCase {
  Future<RecipeModel> call(RecipeModel recipeEntity);
}

class PostRecipeUseCaseImpl implements PostRecipeUseCase {
  final RecipeRepository _recipeRepository;

  PostRecipeUseCaseImpl({required RecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository;

  @override
  Future<RecipeModel> call(RecipeModel recipeEntity) async {
     return await _recipeRepository.postRecipe(recipeEntity);
  }
}