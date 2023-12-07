import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/recipe/data/repository/recipe_repository.dart';
import 'package:minha_receita/modules/recipe/domain/use_case/get_recipe_by_id.dart';

import '../../data/datasource/recipe_datasource.dart';
import '../../domain/repository/recipe_repository.dart';
import '../../presenter/store/recipe_store.dart';

class RecipeInjections {
  var getIt = GetIt.instance;

  init() {
    getIt.registerSingleton<RecipeDataSource>(RecipeDataSourceImpl());
    getIt.registerSingleton<RecipeRepository>(RecipeRepositoryImpl(
      recipeDataSource: getIt<RecipeDataSource>(),
    ));
    getIt.registerSingleton<GetRecipeByIdUseCase>(GetRecipeByIdUseCaseImpl(
      getIt<RecipeRepository>(),
    ));
    getIt.registerSingleton<RecipeStore>(RecipeStore(
      useCase: getIt<GetRecipeByIdUseCase>(),
    ));
  }
}
