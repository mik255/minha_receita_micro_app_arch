import 'package:flutter/foundation.dart';

import '../../../../core/common_http/common_http.dart';
import '../../domain/model/recipe_model.dart';

abstract class RecipeDataSource {
  Future<RecipeModel> getById(String recipeId);
}

class RecipeDataSourceImpl implements RecipeDataSource {
  @override
  Future<RecipeModel> getById(String recipeId) async {
    try{
      var response = await CommonHttp.instance!.get(
        route: '/recipe?$recipeId',
      );
      return RecipeModel.fromJson(response.data);
    }catch(e,_){
      if(kDebugMode){
        print(e);
        print(_);
      }
      rethrow;
    }
  }
}
