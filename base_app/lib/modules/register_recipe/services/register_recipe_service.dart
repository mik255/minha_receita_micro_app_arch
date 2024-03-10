import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_receita/modules/register_recipe/data/repository/recipe_repository.dart';
import 'package:minha_receita/modules/register_recipe/models/ingredient.dart';
import 'package:minha_receita/modules/register_recipe/models/recipe_model.dart';
import '../models/step.dart';

class RegisterRecipeService {
  final RecipeRepository repository = Modular.get();

  RecipeModel recipeModel = RecipeModel(
    id: '',
    userId: '',
    title: '',
    timeInMinutes: 0,
    recipeImgUrlList: [],
    methodOfPreparation: [],
    ingredients: [],
    difficulty: RecipeDificulty.undefined,
    status: RecipeStatus.undefined,
  );

  Future<void> registerRecipe() async {
    //validate(recipeModel);
    await repository.postRecipe(recipeModel);
  }

  void validate(RecipeModel recipe) {
    if (recipe.difficulty == RecipeDificulty.undefined) {
      throw Exception('Dificuldade não pode ser vazia');
    }
    if (recipe.status == RecipeStatus.undefined) {
      throw Exception('Status não pode ser vazio');
    }

    if (recipe.title.isEmpty) {
      throw Exception('Nome da receita não pode ser vazio');
    }
    if (recipe.ingredients.isEmpty) {
      throw Exception('Ingredientes não podem ser vazios');
    }
    if (recipe.methodOfPreparation.isEmpty) {
      throw Exception('Passos não podem ser vazios');
    }
  }

  void setRecipeName(String name) {
    if (name.isEmpty) {
      throw Exception("Nome da receita não pode ser vazio");
    }
    recipeModel.title = name;
  }

  void setRecipeDescription(String description) {
    recipeModel.description = description;
  }

  List<MethodOfPreparation> setMethodOfPreparation(MethodOfPreparation value) {
    return recipeModel.methodOfPreparation..add(value);
  }

  setIngredients(Ingredient ingredient) {
    recipeModel.ingredients.add(ingredient);
  }

  removeIngredients(int index) {
    recipeModel.ingredients.removeAt(index);
  }

  void setTime(int time) {
    if (time == 0) {
      throw Exception('Tempo não pode ser 0');
    }
    recipeModel.timeInMinutes = time;
  }

  void setDifficulty(RecipeDificulty difficulty) {
    recipeModel.difficulty = difficulty;
  }

  void setStatus(RecipeStatus status) {
    recipeModel.status = status;
  }

  void clear() {
    recipeModel = RecipeModel(
      id: '',
      userId: '',
      title: '',
      timeInMinutes: 0,
      recipeImgUrlList: [],
      methodOfPreparation: [],
      ingredients: [],
      difficulty: RecipeDificulty.undefined,
      status: RecipeStatus.undefined,
    );
  }

  void updateMethodOfPreparationDescription(
      MethodOfPreparation methodOfPreparation) {
    recipeModel.methodOfPreparation
        .where((element) => element == methodOfPreparation)
        .first
        .description = methodOfPreparation.description;
  }
}
