import 'package:flutter/cupertino.dart';
import 'package:minha_receita/modules/home/presenter/store/likes_store/states/likes_states.dart';
import '../../../domain/model/post_entity.dart';
import '../../../domain/usecases/post/get_post_likes_use_case.dart';

class LikesStore extends ChangeNotifier {
  final GetPostLikesUseCase getFeedLikesUseCase;

  LikesStore({
    required this.getFeedLikesUseCase,
  });

  LikesState state = FeedLikesLoadingState();

  Future<void> getPostLikes(PostEntity feed,int page) async {
    try {
      state = FeedLikesLoadingState();
      notifyListeners();
      var feedWithComments = await getFeedLikesUseCase(feed,page);
      state = FeedLikesSuccessState(feedWithComments);
      notifyListeners();
    } catch (e) {
      state = FeedLikesFailureState("Serviço indisponível");
      notifyListeners();
    }
  }
}
