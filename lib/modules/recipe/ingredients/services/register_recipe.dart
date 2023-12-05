import '../../../../../core/common_http/common_http.dart';
import '../../main/model/recipe_model.dart';

class RegisterRecipeService {
  Future<void> registerRecipe(RecipeModel recipe) async {
    await CommonHttp.instance?.post(
      url: 'http://10.0.2.2:8081/recipe',
      data: recipe.toJson(),
    );
  }
}
