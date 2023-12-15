import 'package:flutter/cupertino.dart';
import 'package:minha_receita/modules/home/domain/model/post_entity.dart';
import 'package:minha_receita/modules/home/presenter/store/feed_store/states/feed_state.dart';
import '../../../domain/usecases/post/get_post_comments_use_case.dart';
import '../../../domain/usecases/post/get_post_list_use_case.dart';

class FeedStore extends ChangeNotifier {
  final GetListPostUseCase _getListFeedUseCase;

  FeedStore({
    required GetListPostUseCase getListFeedUseCase,
    required GetPostCommentsUseCase getFeedCommentsUseCase,
  }) : _getListFeedUseCase = getListFeedUseCase;

  FeedState state = FeedLoadingState();

  Future<void> getListFeed(int page) async {
    try {
      state = FeedLoadingState();
      notifyListeners();
      var feedsList = await _getListFeedUseCase(page,10);
      state = FeedSuccessState(feedsList);
      notifyListeners();
    } catch (e) {
      state = FeedFailureState("Serviço indisponível");
      notifyListeners();
    }
  }

  void onLikedEvent(PostEntity feed, bool isLiked) {
    feed.userLiked = isLiked;
  }
}
