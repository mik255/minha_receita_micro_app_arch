//make a singleton user model

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.avatarImgUrl,
    this.recipeListId,
  });

  final String? id;
  final String? name;
  final String? avatarImgUrl;
  final String? recipeListId;

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
