import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minha_receita/modules/home/model/like_entity.dart';
import 'package:minha_receita/modules/home/presenter/cubit/states/likes_states.dart';

import '../../data/repository/home_repository.dart';

class LikeCubit extends Cubit<LikeStates> {
  final HomeRepository repository;

  LikeCubit(this.repository,{required this.postId}) : super(LikeInitialState());

  final String postId;
  Future<void> postLike(bool isLike) async {
    try {
      emit(LikeLoading(postId: postId));
      if (isLike) {
        await repository.createLike(postId);
        emit(LikeSuccess(postId: postId));
        return;
      }
      await repository.removeLike(postId);
      emit(UnLikeSuccess(postId: postId));
    } catch (e, _) {
      print(e.toString());
      print(_.toString());
      emit(PostLikeError(msg: e.toString()));
    }
  }
}

class LikeLoadCubit extends Cubit<LikesLoadStates> {
  final HomeRepository repository;

  LikeLoadCubit(this.repository, {required this.postId})
      : super(LikesLoadLoading());

  String postId;
  int page = 0;

  List<LikeEntity> likes = [];
  Future<void> loadLikes() async {
    try {
      emit(LikesLoadLoading());
      final response = await repository.getPostLikes(postId, page, 10);
      likes.addAll(response);
      emit(LikesLoadSuccess(likes: likes));
      page++;
    } catch (e, s) {
      emit(LikesLoadError());
    }
  }
}
