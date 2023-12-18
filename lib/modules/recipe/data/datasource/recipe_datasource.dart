import 'package:flutter/foundation.dart';
import 'package:minha_receita/core/http/core_http.dart';

import '../../domain/model/recipe_model.dart';

abstract class RecipeDataSource {
  Future<RecipeModel> getById(String recipeId);
  Future<void> postRecipe(RecipeModel recipeEntity);
}

class RecipeDataSourceImpl implements RecipeDataSource {
  CoreHttp coreHttp;
  RecipeDataSourceImpl(this.coreHttp);
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
  Future<void> postRecipe(RecipeModel recipeModel) {
    try {
      return coreHttp.post(
        route: '/recipe',
        body: recipeModel.toJson(),
      );
    } catch (e, _) {
      if (kDebugMode) {
        print(e);
        print(_);
      }
      rethrow;
    }
  }
}
