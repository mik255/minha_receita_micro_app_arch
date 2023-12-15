
import 'comment_entity.dart';
import 'like_entity.dart';
class PostEntity {
  PostEntity({
    required this.id,
    required this.recipeId,
    required this.avatarImgUrl, // avatarImgUrl
    required this.imgUrlList, // imgUrlList
    required this.likesCount, // likesCount
    required this.commentsCount, // commentsCount
    required this.userLiked, // userLiked
    required this.description,
    required this.createdAt,
    required this.name, // name
    required this.likesList,
  });

  final String id;
  final String recipeId;
  final String avatarImgUrl;
  final String name;
  final List<String> imgUrlList;
  final int likesCount;
  final int commentsCount;
  bool userLiked;
  final String? description;
  final String? createdAt;
  final List<LikeEntity> likesList;

  factory PostEntity.fromJson(Map<String, dynamic> json) =>
      PostEntity(
        id: json["_id"],
        recipeId: json["recipeId"],
        name: json["name"],
        avatarImgUrl: json["userAvatarUrl"],
        imgUrlList:
        List<String>.from(json["imgUrlList"].map((x) => x)),
        likesList: List<LikeEntity>.from(
            json["listTowFirstLikes"].map((x) => LikeEntity.fromJson(x))),
        likesCount: json["likesCount"],
        userLiked: json["userLiked"],
        description: json["description"],
        createdAt: json["createdAt"],
        commentsCount: json["commentsCount"],
      );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "recipeId": recipeId,
        "name": name,
        "avatarImgUrl": avatarImgUrl,
        "recipeImgUrlList": List<dynamic>.from(imgUrlList.map((x) => x)),
        "listTowFirstLikes":
        List<dynamic>.from(likesList.map((x) => x.toJson())),
        "likesCount": likesCount,
        "userLiked": userLiked,
        "description": description,
        "createdAt": createdAt,
        "commentsCount": commentsCount,
      };
}
