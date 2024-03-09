
import 'package:flutter/foundation.dart';

import '../../../../core/http/core_http.dart';
import '../../models/recipe_model.dart';

class RecipeRepository{
  CoreHttp coreHttp;

  RecipeRepository(this.coreHttp);

  @override
  Future<RecipeModel> getById(String recipeId) async {
    try {
      var response = await coreHttp.get(
        route: '/recipe?$recipeId',
      );
      return RecipeModel.fromJson(response.data);
    } catch (e, _) {
      if (kDebugMode) {
        print(e);
        print(_);
      }
      rethrow;
    }
  }

  @override
  Future<RecipeModel> postRecipe(RecipeModel recipeModel) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var response = await coreHttp.post(
        route: '/recipes/create',
        body: recipeModel.toJson(),
      );
      return RecipeModel.fromJson(response.data['value']);
    } catch (e, _) {
      if (kDebugMode) {
        print(e);
        print(_);
      }
      rethrow;
    }
  }
}