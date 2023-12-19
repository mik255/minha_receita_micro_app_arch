import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:minha_receita/modules/home/domain/model/comment_entity.dart';
import 'package:minha_receita/modules/home/presenter/store/comments_store/states/comments_states.dart';
import '../../../domain/model/post_entity.dart';
import '../../../domain/usecases/post/comments_use_case.dart';

class CommentsStore extends ChangeNotifier {
  final GetPostCommentsUseCase _getFeedCommentsUseCase;

  CommentsStore({
    required GetPostCommentsUseCase getFeedCommentsUseCase,
  }) : _getFeedCommentsUseCase = getFeedCommentsUseCase;
  CommentsState state = CommentLoadingState();
  List<CommentEntity> comments = [];

  Future<void> getPostComments(PostEntity feed, int page) async {
    try {
      state = CommentLoadingState();
      notifyListeners();
      var feedWithComments =
          await _getFeedCommentsUseCase.getComments(feed.id, page, 10);
      comments.addAll(feedWithComments);
      comments = comments.toSet().toList();
      comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      comments.where((element) => element.postId==feed.id).first;
      state = CommentSuccessState(comments);
      notifyListeners();
    } catch (e, _) {
      if (kDebugMode) {
        print(_);
      }
      state = CommentFailureState("Serviço indisponível");
      notifyListeners();
    }
  }

  Future<bool> createComment(PostEntity feed, String text) async {
    try {
      state = CommentLoadingState();
      notifyListeners();
      var feedWithComments =
          await _getFeedCommentsUseCase.createComment(feed.id, text);
      comments.add(feedWithComments);
      comments = comments.toSet().toList();
      comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      comments.where((element) => element.postId==feed.id).first;
      state = CommentSuccessState(comments);
      getPostComments(feed, 1);
      notifyListeners();
      return true;
    } catch (e, _) {
      print(e);
      if (kDebugMode) {
        print(_);
      }
      state = CommentFailureState("Serviço indisponível");
      notifyListeners();
      return false;
    }
  }
}
