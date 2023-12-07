import '../../../../../core/models/user.dart';
import '../../../Recipe/domain/model/ingredient.dart';
import '../../../Recipe/domain/model/step.dart';

class RecipeModel {
  RecipeModel({
    required this.userId,
    required this.title,
    required this.timeInMinutes,
    required this.imgUrlList,
    this.description,
    required this.steps,
    required this.ingredients,
  });

  String userId;
  String title;
  String? description;
  num timeInMinutes;
  List<String> imgUrlList;
  List<Step> steps;
  List<Ingredient> ingredients;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        userId: json['userId'],
        title: json['title'],
        timeInMinutes: json['timeInMinutes'],
        description: json['description'],
        imgUrlList: List<String>.from(json['imgUrlList'].map((x) => x)),
        steps: List<Step>.from(json['steps'].map((x) => Step.fromJson(x))),
        ingredients: List<Ingredient>.from(
            json['ingredients'].map((x) => Ingredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'user': User.id,
        'title': title,
        'timeInMinutes': timeInMinutes,
        'imgUrlList': imgUrlList,
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
    List<Step>? steps,
    List<Ingredient>? ingredients,
    List<String>? imgUrlList,
  }) {
    return RecipeModel(
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      timeInMinutes: timeInMinutes ?? this.timeInMinutes,
      imgUrlList: imgUrlList ?? this.imgUrlList,
      steps: steps ?? this.steps,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
