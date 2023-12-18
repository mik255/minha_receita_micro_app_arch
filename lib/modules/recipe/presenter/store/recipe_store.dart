import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/common/user/domain/models/user.dart';
import 'package:minha_receita/modules/recipe/domain/model/recipe_model.dart';
import 'package:minha_receita/modules/recipe/domain/use_case/post_recipe.dart';
import 'package:minha_receita/modules/recipe/presenter/states/ingredients_states.dart';
import '../../../../core/services/files_service_interface.dart';
import '../../../Recipe/domain/model/ingredient.dart';
import '../../../Recipe/domain/model/step.dart';
import '../../domain/use_case/get_recipe_by_id.dart';

enum RecipeStatus {
  undefined,
  saudavel,
  doce,
  salgado,
  bebida,
  lanche,
  refeicao;

  String getName() {
    switch (this) {
      case RecipeStatus.undefined:
        return 'Tipo da receita';
      case RecipeStatus.saudavel:
        return 'Saudável';
      case RecipeStatus.doce:
        return 'Doce';
      case RecipeStatus.salgado:
        return 'Salgado';
      case RecipeStatus.bebida:
        return 'Bebida';
      case RecipeStatus.lanche:
        return 'Lanche';
      case RecipeStatus.refeicao:
        return 'Refeição';
    }
  }
}

enum RecipeDificulty {
  undefined,
  facil,
  medio,
  dificil;

  String getName() {
    switch (this) {
      case RecipeDificulty.undefined:
        return 'Dificuldade';
      case RecipeDificulty.facil:
        return 'Fácil';
      case RecipeDificulty.medio:
        return 'Médio';
      case RecipeDificulty.dificil:
        return 'Difícil';
    }
  }
}

class RecipeStore extends ChangeNotifier {
  final GetRecipeByIdUseCase _useCase;
  final PostRecipeUseCase _postRecipeUseCase;
  final FileServiceInterface _fileServiceInterface;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeTextController = TextEditingController();
  List<TextEditingController> ingredientsController = [];
  List<TextEditingController> stepsController = [];
  int timeInMinutes = 0;
  RecipeDificulty dificulty = RecipeDificulty.undefined;
  RecipeStatus status = RecipeStatus.saudavel;
  bool buttonValidade = false;
  RecipeState state = RecipeLoadingState();
  var files = <File>[];
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

  RecipeStore({
    required GetRecipeByIdUseCase useCase,
    required PostRecipeUseCase postRecipeUseCase,
    required FileServiceInterface fileServiceInterface,
  })  : _useCase = useCase,
        _postRecipeUseCase = postRecipeUseCase,
        _fileServiceInterface = fileServiceInterface;

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

  void removeIngredient(TextEditingController e) {
    ingredientsController.remove(e);
    notifyListeners();
  }

  void addStep() {
    stepsController.add(TextEditingController());
    notifyListeners();
  }

  void removeStep(TextEditingController e) {
    stepsController.remove(e);
    notifyListeners();
  }

  void setDificulty(RecipeDificulty value) {
    dificulty = value;
    notifyListeners();
  }

  void setStatus(RecipeStatus value) {
    status = value;
    notifyListeners();
  }

  String? buttonIsEnable() {
    if (descriptionController.text.isEmpty) {
      return 'Descrição de sobre a receita não pode ser vazia';
    }
    if (timeInMinutes == 0) {
      return 'tempo não pode ser 0';
    }
    if (dificulty == RecipeDificulty.undefined) {
      return 'adicione uma dificuldade';
    }
    if (status == RecipeStatus.undefined) {
      return 'Adicione o tipo da receita';
    }
    if (ingredientsController.isEmpty) {
      return 'Adicione os ingredientes';
    }
    if (stepsController.isEmpty) {
      return 'Adicione os passos';
    }

    buttonValidade = false;
    return null;
  }

  void addFiles(List<File> values) {
    files.addAll(values);
    notifyListeners();
  }



  void addTime() {
    timeInMinutes = int.parse(timeTextController.text);
    notifyListeners();
  }

  void postRecipe() async {
    try {
      var listImagesUrl = await _fileServiceInterface.upload(files);
      var recipe = recipeModel.copyWith(
        userId: GetIt.I.get<UserModel>().id,
        description: descriptionController.text,
        title: titleController.text,
        timeInMinutes: timeInMinutes,
        difficulty: dificulty.getName(),
        status: status.getName(),
        ingredients: ingredientsController
            .map((e) => Ingredient(description: e.text))
            .toList(),
        steps: stepsController
            .map((e) =>
                Step(description: e.text, step: stepsController.indexOf(e)))
            .toList(),
        recipeImgUrlList: listImagesUrl,
      );
      await _postRecipeUseCase(recipe);
      state = RecipeSuccessState(recipeModel: recipe);
      notifyListeners();
    } catch (e,_) {
      print(_);
    //  state = RecipeException();
    //  notifyListeners();
    }
  }

  Future<File> base64ToFile(String base64String, String filePath) async {
    Uint8List bytes = base64Decode(base64String);

    File file = File(filePath);
    await file.writeAsBytes(bytes);

    return file;
  }
}
