import 'package:minha_receita/modules/home/domain/model/feed_entity.dart';

sealed class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<FeedEntity> feedEntityList;

  HomeSuccessState(this.feedEntityList);
}

class HomeFailureState extends HomeState {
  final String message;

  HomeFailureState(this.message);
}
