import 'package:flutter/cupertino.dart';
import 'package:minha_receita/modules/home/presenter/store/comments_store/states/comments_states.dart';
import '../../../domain/model/post_entity.dart';
import '../../../domain/usecases/post/get_post_comments_use_case.dart';

class CommentsStore extends ChangeNotifier {
  final GetPostCommentsUseCase _getFeedCommentsUseCase;

  CommentsStore({
    required GetPostCommentsUseCase getFeedCommentsUseCase,
  }) : _getFeedCommentsUseCase = getFeedCommentsUseCase;
  CommentsState state = CommentLoadingState();

  Future<void> getPostComments(PostEntity feed,int page) async {
    try {
      state = CommentLoadingState();
      notifyListeners();
      var feedWithComments = await _getFeedCommentsUseCase(feed,page);
      state = CommentSuccessState(feedWithComments);
      notifyListeners();
    } catch (e,_) {
      print(_);
      state = CommentFailureState("Serviço indisponível");
      notifyListeners();
    }
  }
}
