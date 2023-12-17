class LikeEntity {
  LikeEntity({
    required this.urlImg,
    required this.name,
    required this.description,
    required this.isFallowing,
  });

  String urlImg;
  String name;
  String description;
  bool isFallowing;

  factory LikeEntity.fromJson(Map<String, dynamic> json) => LikeEntity(
        urlImg: json["avatarUrl"]??'https://i.stack.imgur.com/l60Hf.png',
        name: json["userName"],
        description: json["description"]??'Sem descrição',
        isFallowing: json["userIsFollowing"],
      );

  Map<String, dynamic> toJson() => {
        "urlImg": urlImg,
        "name": name,
        "description": description,
        "isFallowing": isFallowing,
      };
}
