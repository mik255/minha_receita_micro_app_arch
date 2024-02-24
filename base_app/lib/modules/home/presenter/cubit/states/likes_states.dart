import 'package:minha_receita/modules/home/model/like_entity.dart';

class LikeStates {}

class LikeInitialState extends LikeStates {}

class LikeLoading extends LikeStates {
  String postId;

  LikeLoading({required this.postId});
}

class LikeSuccess extends LikeStates {
  String postId;

  LikeSuccess({required this.postId});
}

class UnLikeSuccess extends LikeStates {
  String postId;

  UnLikeSuccess({required this.postId});
}

class PostLikeError extends LikeStates {
  String msg;

  PostLikeError({required this.msg});
}

class LikesLoadStates {}

class LikesLoadLoading extends LikesLoadStates {}

class LikesLoadSuccess extends LikesLoadStates {
  List<LikeEntity> likes;

  LikesLoadSuccess({required this.likes});
}

class LikesLoadError extends LikesLoadStates {}
