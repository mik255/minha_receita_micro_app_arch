import '../../../../../core/common_http/common_http.dart';
import '../../../recipe/domain/model/recipe_model.dart';

abstract class RecipeRepository {
  Future<RecipeModel> getById(String recipeId);
}

class RecipeRepositoryImpl implements RecipeRepository {
  @override
  Future<RecipeModel> getById(String recipeId) async {
    var response = await CommonHttp.instance!.get(
      route: '/recipe?$recipeId',
    );
    return RecipeModel.fromJson(response.data);
  }
}
