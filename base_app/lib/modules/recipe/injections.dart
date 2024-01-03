import 'package:get_it/get_it.dart';
import 'package:micro_app_common/micro_app_common.dart';
import 'package:micro_app_core/micro_app_core.dart';
import 'package:minha_receita/modules/recipe/data/repository/recipe_repository.dart';
import 'package:minha_receita/modules/recipe/domain/use_case/get_recipe_by_id.dart';
import 'package:minha_receita/modules/recipe/domain/use_case/post_recipe.dart';
import 'data/datasource/recipe_datasource.dart';
import 'domain/repository/recipe_repository.dart';
import 'presenter/store/recipe_store.dart';

class RecipeInjections {
  var getIt = GetIt.instance;

  init() {
    getIt.registerSingleton<RecipeDataSource>(RecipeDataSourceImpl(
      getIt<CoreHttp>(),
    ));
    getIt.registerSingleton<RecipeRepository>(RecipeRepositoryImpl(
      recipeDataSource: getIt<RecipeDataSource>(),
    ));
    getIt.registerSingleton<GetRecipeByIdUseCase>(GetRecipeByIdUseCaseImpl(
      getIt<RecipeRepository>(),
    ));
    getIt.registerSingleton<PostRecipeUseCase>(PostRecipeUseCaseImpl(
        recipeRepository: getIt<RecipeRepository>(),
    ));
    getIt.registerSingleton<RecipeStore>(RecipeStore(
      useCase: getIt<GetRecipeByIdUseCase>(),
      postRecipeUseCase: getIt<PostRecipeUseCase>(),
      fileServiceInterface: ServerFileService(
        getIt<CoreHttp>(),
      ),
    ));
  }
}
