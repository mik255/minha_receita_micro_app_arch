import 'comment_entity.dart';
import 'like_entity.dart';

class FeedEntity {
  FeedEntity({
    required this.avatarImgUrl,
    required this.recipeImgUrlList,
    required this.likes,
    required this.comments,
    required this.userLiked,
    required this.description,
    required this.createdAt,
    required this.likesList,
    required this.name,
    required this.id,
  });

  final String avatarImgUrl;
  final String name;
  final List<String> recipeImgUrlList;
  final int likes;
  final bool userLiked;
  final List<CommentEntity> comments;
  final String? description;
  final String? createdAt;
  final List<LikeEntity> likesList;
  final String id;

  factory FeedEntity.fromJson(Map<String, dynamic> json) => FeedEntity(
        id: json["id"],
        name: json["name"],
        avatarImgUrl: json["avatarImgUrl"],
        recipeImgUrlList:
            List<String>.from(json["recipeImgUrlList"].map((x) => x)),
        likes: json["likes"],
        userLiked: json["userLiked"],
        comments: List<CommentEntity>.from(
            json["comments"].map((x) => CommentEntity.fromJson(x))),
        likesList: List<LikeEntity>.from(
            json["likesList"].map((x) => LikeEntity.fromJson(x))),
        description: json["description"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatarImgUrl": avatarImgUrl,
        "recipeImgUrlList": List<dynamic>.from(recipeImgUrlList.map((x) => x)),
        "likes": likes,
        "likesList": List<dynamic>.from(likesList.map((x) => x.toJson())),
        "userLiked": userLiked,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "description": description,
        "created_at": createdAt,
      };
}
