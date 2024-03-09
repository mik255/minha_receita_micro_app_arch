import 'package:minha_receita/modules/register_recipe/models/step.dart';

import 'ingredient.dart';

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

class RecipeModel {
  RecipeModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.timeInMinutes,
    required this.recipeImgUrlList,
    required this.methodOfPreparation,
    required this.ingredients,
    required this.difficulty,
    required this.status,
    this.description,
  });

  String id;
  String userId;
  String title;
  String? description;
  num timeInMinutes;
  List<String> recipeImgUrlList;
  List<MethodOfPreparation> methodOfPreparation;
  List<Ingredient> ingredients;
  RecipeDificulty difficulty;
  RecipeStatus status;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json['_id'],
        userId: json['userId'],
        title: json['title'],
        timeInMinutes: json['timeInMinutes'],
        description: json['description'],
        recipeImgUrlList:
            List<String>.from(json['recipeImgUrlList'].map((x) => x)),
        methodOfPreparation:
            List<MethodOfPreparation>.from(json['methodOfPreparations'].map(
          (x) => MethodOfPreparation.fromJson(x),
        )),
        ingredients: List<Ingredient>.from(
            json['ingredients'].map((x) => Ingredient.fromJson(x))),
        difficulty: json["difficulty"],
        status: json["type"],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'title': title,
        'timeInMinutes': timeInMinutes,
        'recipeImgUrlList': recipeImgUrlList,
        'description': description,
        'methodOfPreparations':
            List<dynamic>.from(methodOfPreparation.map((x) => x.toJson())),
        'ingredients': List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "difficulty": difficulty.getName(),
        "type": status.getName(),
      };

  //copyWith
  RecipeModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    num? timeInMinutes,
    String? imgUrl,
    List<MethodOfPreparation>? methodOfPreparation,
    List<Ingredient>? ingredients,
    List<String>? recipeImgUrlList,
    RecipeDificulty? difficulty,
    RecipeStatus? status,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      timeInMinutes: timeInMinutes ?? this.timeInMinutes,
      recipeImgUrlList: recipeImgUrlList ?? this.recipeImgUrlList,
      methodOfPreparation: methodOfPreparation ?? this.methodOfPreparation,
      ingredients: ingredients ?? this.ingredients,
      difficulty: difficulty ?? this.difficulty,
      status: status ?? this.status,
    );
  }
}
