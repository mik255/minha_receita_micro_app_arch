//make a singleton user model

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.avatarImgUrl,
    required this.recipeListId,
  });

  final String id;
  final String name;
  final String avatarImgUrl;
  final String recipeListId;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        avatarImgUrl: json["avatarImgUrl"],
        recipeListId: json["recipeListId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatarImgUrl": avatarImgUrl,
        "recipeListId": recipeListId,
      };
}
