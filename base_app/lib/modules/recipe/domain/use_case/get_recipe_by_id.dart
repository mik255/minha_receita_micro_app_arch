import 'package:minha_receita/modules/recipe/domain/model/recipe_model.dart';

import '../repository/recipe_repository.dart';

abstract class GetRecipeByIdUseCase {
  Future<RecipeModel> call(String id);
}

class GetRecipeByIdUseCaseImpl extends GetRecipeByIdUseCase {
  final RecipeRepository _recipeRepository;

  GetRecipeByIdUseCaseImpl(RecipeRepository recipeRepository)
      : _recipeRepository = recipeRepository;

  @override
  Future<RecipeModel> call(String id) async {
    return await _recipeRepository.getById(id);
  }
}
