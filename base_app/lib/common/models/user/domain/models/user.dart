class UserModel {
  UserModel({
    this.id,
    this.name,
    this.avatarImgUrl,
    this.email,
  });

  String? id;
  String? name;
  String? avatarImgUrl;
  String? email;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["nome"],
        avatarImgUrl: json["avatarImgUrl"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatarImgUrl": avatarImgUrl,
        "email": email,
      };

  void setUser(UserModel user) {
    id = user.id;
    name = user.name;
    avatarImgUrl = user.avatarImgUrl;
    email = user.email;
  }
}
