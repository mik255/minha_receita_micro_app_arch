import 'comment_entity.dart';
import 'like_entity.dart';

class PostEntity {
  PostEntity({
    required this.id,
    required this.avatarImgUrl,
    required this.recipeImgUrlList,
    required this.likesCount,
    required this.userLiked,
    required this.description,
    required this.createdAt,
    required this.name,
    this.likesList = const [],
    this.comments = const [],
  });

  final String id;
  final String avatarImgUrl;
  final String name;
  final List<String> recipeImgUrlList;
  final int likesCount;
  final bool userLiked;
  late List<CommentEntity> comments;
  final String? description;
  final String? createdAt;
  late List<LikeEntity> likesList;

  factory PostEntity.fromJson(Map<String, dynamic> json) => PostEntity(
        id: json["id"],
        name: json["name"],
        avatarImgUrl: json["avatarImgUrl"],
        recipeImgUrlList:
            List<String>.from(json["recipeImgUrlList"].map((x) => x)),
        likesList: List<LikeEntity>.from(
            json["likesList"].map((x) => LikeEntity.fromJson(x))),
        likesCount: json["likesCount"],
        userLiked: json["userLiked"],
        description: json["description"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatarImgUrl": avatarImgUrl,
        "recipeImgUrlList": List<dynamic>.from(recipeImgUrlList.map((x) => x)),
        "likesList": List<dynamic>.from(likesList.map((x) => x.toJson())),
        "likes": likesCount,
        "userLiked": userLiked,
        "description": description,
        "created_at": createdAt,
      };
}
