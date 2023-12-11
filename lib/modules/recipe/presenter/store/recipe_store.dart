import 'package:flutter/cupertino.dart';
import 'package:minha_receita/modules/recipe/domain/model/recipe_model.dart';
import 'package:minha_receita/modules/recipe/presenter/states/ingredients_states.dart';
import '../../domain/use_case/get_recipe_by_id.dart';

class RecipeStore extends ChangeNotifier {
  final GetRecipeByIdUseCase _useCase;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  List<TextEditingController> ingredientsController = [];
  List<TextEditingController> stepsController = [];
  RecipeState state = RecipeLoadingState();
  var recipeModel = RecipeModel(
    userId: '',
    title: 'Nova Receita',
    timeInMinutes: 0,
    recipeImgUrlList: [],
    steps: [],
    ingredients: [],
    difficulty: 'dificuldade',
    status: 'tipo da receita',
  );

  RecipeStore({required GetRecipeByIdUseCase useCase}) : _useCase = useCase;

  void getRecipe(String? recipeId) async {
    ingredientsController = [];
    stepsController = [];
    state = RecipeLoadingState();
    notifyListeners();
    try {
      if (recipeId != null) {
        recipeModel = await _useCase(recipeId);
      }

      descriptionController.text = recipeModel.description ?? '';
      titleController.text = recipeModel.title ?? '';
      for (var element in recipeModel.ingredients) {
        ingredientsController
            .add(TextEditingController(text: element.description));
      }
      recipeModel.steps.sort((a, b) => a.step.compareTo(b.step));
      for (var element in recipeModel.steps) {
        stepsController.add(TextEditingController(text: element.description));
      }

      state = RecipeSuccessState(recipeModel: recipeModel);
      notifyListeners();
    } catch (e) {
      state = RecipeException();
      notifyListeners();
    }
  }

  void addIngredient() {
    ingredientsController.add(TextEditingController());
    notifyListeners();
  }

  void addStep() {
    stepsController.add(TextEditingController());
    notifyListeners();
  }
}
