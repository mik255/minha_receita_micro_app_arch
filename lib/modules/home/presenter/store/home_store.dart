import 'package:flutter/cupertino.dart';
import '../../domain/usecases/get_list_feed.dart';
import '../states/home_state.dart';

class HomeStore extends ChangeNotifier {
  final GetListFeedUseCase _getListFeedUseCase;

  HomeStore({required GetListFeedUseCase getListFeedUseCase})
      : _getListFeedUseCase = getListFeedUseCase;

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
