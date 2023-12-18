

import '../model/recipe_model.dart';
import '../repository/recipe_repository.dart';

abstract class PostRecipeUseCase {
  Future<void> call(RecipeModel recipeEntity);
}

class PostRecipeUseCaseImpl implements PostRecipeUseCase {
  final RecipeRepository _recipeRepository;

  PostRecipeUseCaseImpl({required RecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository;

  @override
  Future<void> call(RecipeModel recipeEntity) async {
     await _recipeRepository.postRecipe(recipeEntity);
  }
}