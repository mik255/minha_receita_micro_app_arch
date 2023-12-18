import '../../../Recipe/domain/model/ingredient.dart';
import '../../../Recipe/domain/model/step.dart';

class RecipeModel {
  RecipeModel({
    required this.userId,
    required this.title,
    required this.timeInMinutes,
    required this.recipeImgUrlList,
    required this.steps,
    required this.ingredients,
    required this.difficulty,
    required this.status,
    this.description,
  });

  String userId;
  String title;
  String? description;
  num timeInMinutes;
  List<String> recipeImgUrlList;
  List<Step> steps;
  List<Ingredient> ingredients;
  final String difficulty;
  final String status;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        userId: json['userId'],
        title: json['title'],
        timeInMinutes: json['timeInMinutes'],
        description: json['description'],
        recipeImgUrlList:
            List<String>.from(json['recipeImgUrlList'].map((x) => x)),
        steps: List<Step>.from(json['steps'].map((x) => Step.fromJson(x))),
        ingredients: List<Ingredient>.from(
            json['ingredients'].map((x) => Ingredient.fromJson(x))),
        difficulty: json["difficulty"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'title': title,
        'timeInMinutes': timeInMinutes,
        'recipeImgUrlList': recipeImgUrlList,
        'description': description,
        'steps':
            List<dynamic>.from(steps.map((x) => x.toJson())),
        'ingredients': List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "difficulty": difficulty,
        "status": status,
      };

  //copyWith
  RecipeModel copyWith({
    String? userId,
    String? title,
    String? description,
    num? timeInMinutes,
    String? imgUrl,
    List<Step>? steps,
    List<Ingredient>? ingredients,
    List<String>? recipeImgUrlList,
    String? difficulty,
    String? status,
  }) {
    return RecipeModel(
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      timeInMinutes: timeInMinutes ?? this.timeInMinutes,
      recipeImgUrlList: recipeImgUrlList ?? this.recipeImgUrlList,
      steps: steps ?? this.steps,
      ingredients: ingredients ?? this.ingredients,
      difficulty: difficulty ?? this.difficulty,
      status: status ?? this.status,
    );
  }
}
