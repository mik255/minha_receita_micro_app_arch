import 'package:flutter/cupertino.dart';
import 'package:minha_receita/modules/home/presenter/store/home_store/states/home_state.dart';
import '../../../domain/usecases/post/get_post_comments_use_case.dart';
import '../../../domain/usecases/post/get_post_list_use_case.dart';

class HomeStore extends ChangeNotifier {
  final GetListPostUseCase _getListFeedUseCase;

  HomeStore({
    required GetListPostUseCase getListFeedUseCase,
    required GetPostCommentsUseCase getFeedCommentsUseCase,
  }) : _getListFeedUseCase = getListFeedUseCase;

  HomeState state = HomeLoadingState();

  Future<void> getListFeed() async {
    try {
      state = HomeLoadingState();
      notifyListeners();
      var feedsList = await _getListFeedUseCase();
      state = HomeSuccessState(feedsList);
      notifyListeners();
    } catch (e) {
      state = HomeFailureState("Serviço indisponível");
      notifyListeners();
    }
  }
}
