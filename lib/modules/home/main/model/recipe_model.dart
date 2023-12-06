import '../../../../../core/models/user.dart';
import '../../ingredients/model/ingredient.dart';
import '../../ingredients/model/step.dart';


class RecipeModel {
  RecipeModel({
    required this.userId,
    required this.title,
    required this.timeInMinutes,
    this.imgUrl,
    this.description,
    required this.steps,
    required this.ingredients,
  });

  String userId;
  String title;
  String? description;
  num timeInMinutes;
  String? imgUrl;
  List<Step> steps;
  List<Ingredient> ingredients;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        userId: json['userId'],
        title: json['title'],
        timeInMinutes: json['timeInMinutes'],
        description: json['description'],
        imgUrl: json['imgURL'],
        steps: List<Step>.from(
            json['steps']
                .map((x) => Step.fromJson(x))),
        ingredients: List<Ingredient>.from(
            json['ingredients'].map((x) => Ingredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'user': User.id,
        'title': title,
        'timeInMinutes': timeInMinutes,
        'imgUrl': imgUrl,
        'description': description,
        'methodOfPreparationField':
            List<dynamic>.from(steps.map((x) => x.toJson())),
        'ingredients': List<dynamic>.from(ingredients.map((x) => x.toJson())),
      };

  //copyWith
  RecipeModel copyWith({
    String? userId,
    String? title,
    String? description,
    num? timeInMinutes,
    String? imgUrl,
    List<Step>? methodOfPreparationField,
    List<Ingredient>? ingredients,
  }) {
    return RecipeModel(
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      timeInMinutes: timeInMinutes ?? this.timeInMinutes,
      imgUrl: imgUrl ?? this.imgUrl,
      steps:
          methodOfPreparationField ?? this.steps,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
