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
        urlImg: json["userImgUrl"]??'https://i.stack.imgur.com/l60Hf.png',
        name: json["userName"],
        description: json["description"]??'Sem descrição',
        isFallowing: json["isUserFollowing"],
      );

  Map<String, dynamic> toJson() => {
        "urlImg": urlImg,
        "name": name,
        "description": description,
        "isFallowing": isFallowing,
      };
}
