import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/recipe/data/repository/recipe_repository.dart';

import '../../presenter/store/recipe_store.dart';

class RecipeInjections {
  var getIt = GetIt.instance;

  init() {
    getIt.registerSingleton<RecipeRepository>(RecipeRepositoryImpl());
    getIt.registerSingleton<RecipeStore>(RecipeStore(
      repository: getIt<RecipeRepository>(),
    ));
  }
}
