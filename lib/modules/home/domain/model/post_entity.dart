
import 'comment_entity.dart';
import 'like_entity.dart';

class PostEntity {
  PostEntity({
    required this.id,
    required this.avatarImgUrl,
    required this.recipeImgUrlList,
    required this.likesCount,
    required this.commentsCount,
    required this.userLiked,
    required this.description,
    required this.createdAt,
    required this.name,
    required this.likesList,
    required this.comments,
  });

  final String id;
  final String avatarImgUrl;
  final String name;
  final List<String> recipeImgUrlList;
  final int likesCount;
  final int commentsCount;
  bool userLiked;
  final String? description;
  final String? createdAt;
  final List<LikeEntity> likesList;
  final List<CommentEntity> comments;

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
        commentsCount: json["commentsCount"],
        comments: json["comments"]!=null?List<CommentEntity>.from(
            json["comments"].map((x) => CommentEntity.fromJson(x))):[],
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
        "commentsCount": commentsCount,
      };
}
