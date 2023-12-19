import 'package:flutter/cupertino.dart';
import 'package:minha_receita/modules/home/domain/model/post_entity.dart';
import 'package:minha_receita/modules/home/presenter/store/feed_store/states/feed_state.dart';
import '../../../domain/usecases/post/comments_use_case.dart';
import '../../../domain/usecases/post/get_post_list_use_case.dart';

class FeedStore extends ChangeNotifier {
  final GetListPostUseCase _getListFeedUseCase;

  FeedStore({
    required GetListPostUseCase getListFeedUseCase,
    required GetPostCommentsUseCase getFeedCommentsUseCase,
  }) : _getListFeedUseCase = getListFeedUseCase;

  FeedState state = FeedLoadingState();
  var feedList = <PostEntity>[];
  Future<void> getListFeed(int page) async {
    try {
      state = FeedLoadingState();
      notifyListeners();
      var feedsList = await _getListFeedUseCase(page,3);
      feedList.addAll(feedsList.toSet().toList());
      feedList.sort((a, b) => DateTime.parse(b.createdAt!).compareTo(DateTime.parse(a.createdAt!)));
      await Future.delayed(const Duration(seconds: 1));
      state = FeedSuccessState(feedList);
      notifyListeners();
    } catch (e) {
      state = FeedFailureState("Serviço indisponível");
      notifyListeners();
    }
  }

  Future<void> getMore(int page) async {
    try {
      var feedsList = await _getListFeedUseCase(page,3);
      feedList.addAll(feedsList.toList());
      feedList = feedList.toSet().toList();
      feedList.sort((a, b) => DateTime.parse(b.createdAt!).compareTo(DateTime.parse(a.createdAt!)));
      state = FeedSuccessState(feedList);
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
