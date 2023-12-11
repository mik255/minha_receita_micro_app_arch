//make a singleton user model

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.avatarImgUrl,
    this.recipeListId,
  });

  String? id;
  String? name;
  String? avatarImgUrl;
  String? recipeListId;

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

  void setUser(UserModel user) {
    id = user.id;
    name = user.name;
    avatarImgUrl = user.avatarImgUrl;
    recipeListId = user.recipeListId;
  }
}
