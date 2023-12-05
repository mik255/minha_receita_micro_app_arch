import '../../../../../core/common_http/common_http.dart';
import '../model/recipe_model.dart';

enum RecipeType {
  pop,
  newRecipe,
  favorites;

  @override
  String toString() {
    switch (this) {
      case RecipeType.pop:
        return 'pop';
      case RecipeType.newRecipe:
        return 'news';
      case RecipeType.favorites:
        return 'favorites';
    }
  }
}
class GetRecipeService{
  Future<List<RecipeModel>> call({required RecipeType queryType}) async {
    var response = await CommonHttp.instance!.get(
      url: 'http://10.0.2.2:8081/recipe?${queryType.toString()}',
    );
    return (response.data as List).map((e) => RecipeModel.fromJson(e)).toList();
  }
}
