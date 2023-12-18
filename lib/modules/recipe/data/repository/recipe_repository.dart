import 'package:minha_receita/modules/recipe/data/datasource/recipe_datasource.dart';
import '../../../recipe/domain/model/recipe_model.dart';
import '../../domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDataSource _recipeDataSource;

  RecipeRepositoryImpl({required RecipeDataSource recipeDataSource})
      : _recipeDataSource = recipeDataSource;

  @override
  Future<RecipeModel> getById(String recipeId) async {
    return await _recipeDataSource.getById(recipeId);
  }

  @override
  Future<void> postRecipe(RecipeModel recipeModel) {
    return _recipeDataSource.postRecipe(recipeModel);
  }
}
