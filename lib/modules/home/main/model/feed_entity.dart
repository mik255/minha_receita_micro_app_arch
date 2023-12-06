import 'comment_entity.dart';
import 'like_entity.dart';

class FeedEntity {
  FeedEntity({
    required this.imgUrl,
    required this.recipeImgUrlList,
    required this.likes,
    required this.comments,
    required this.userLiked,
    required this.description,
    required this.createdAt,
    required this.likesList,
    required this.name,
  });

  final String imgUrl;
  final String name;
  final List<String> recipeImgUrlList;
  final int likes;
  final bool userLiked;
  final List<CommentEntity> comments;
  final String? description;
  final String? createdAt;
  final List<LikeEntity> likesList;

  factory FeedEntity.fromJson(Map<String, dynamic> json) => FeedEntity(
        name: json["name"],
        imgUrl: json["img_url"],
        recipeImgUrlList:
            List<String>.from(json["recipe_img_url_list"].map((x) => x)),
        likes: json["likes"],
        userLiked: json["user_liked"],
        comments: List<CommentEntity>.from(
            json["comments"].map((x) => CommentEntity.fromJson(x))),
        likesList: List<LikeEntity>.from(
            json["likes_list"].map((x) => LikeEntity.fromJson(x))),
        description: json["description"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "img_url": imgUrl,
        "recipe_img_url_list":
            List<dynamic>.from(recipeImgUrlList.map((x) => x)),
        "likes": likes,
        "likes_list": List<dynamic>.from(likesList.map((x) => x.toJson())),
        "user_liked": userLiked,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "description": description,
        "created_at": createdAt,
      };
}
