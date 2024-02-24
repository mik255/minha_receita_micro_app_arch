import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minha_receita/modules/home/presenter/cubit/states/comments_states.dart';

import '../../data/repository/home_repository.dart';
import '../../model/comment_entity.dart';

class CommentsCubit extends Cubit<CommentStates> {
  final HomeRepository repository;

  CommentsCubit(this.repository, {required this.postId})
      : super(PostCommentInitial());

  String postId;

  void postComment(String value) async {
    try {
      emit(PostCommentLoading());
      await repository.createComment(postId, value);
      emit(PostCommentSuccess());
    } catch (e, s) {
      emit(PostCommentError());
    }
  }
}

class CommentsLoadCubit extends Cubit<CommentsLoadStates> {
  final HomeRepository repository;

  CommentsLoadCubit(this.repository, {required this.postId})
      : super(CommentsLoadLoading());

  String postId;
  int page = 0;

  List<CommentEntity> commentsList = [];

  Future<void> loadComments() async {
    try {
      emit(CommentsLoadLoading());
       var response = await repository.getPostComments(postId, page, 10);
      commentsList.addAll(response);
      emit(CommentsLoadSuccess(comments: commentsList));
      page++;
    } catch (e, s) {
      emit(CommentsLoadError());
    }
  }

  void addComment(
    value,
    String name,
    String imgUrl,
  ) {
    commentsList.add(CommentEntity(
      id: '',
      comment: value,
      createdAt: DateTime.now().toIso8601String(),
      name: name,
      urlImg: imgUrl,
      userId: '',
    ));
    emit(CommentsLoadSuccess(comments: commentsList));
  }
}
