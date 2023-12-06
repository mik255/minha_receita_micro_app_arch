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
        urlImg: json["url_img"],
        name: json["name"],
        description: json["description"],
        isFallowing: json["is_fallowing"],
      );

  Map<String, dynamic> toJson() => {
        "url_img": urlImg,
        "name": name,
        "description": description,
        "is_fallowing": isFallowing,
      };
}
