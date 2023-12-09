import 'package:minha_receita/modules/home/domain/model/post_entity.dart';

sealed class FeedState {}

class FeedLoadingState extends FeedState {}

class FeedSuccessState extends FeedState {
  final List<PostEntity> feedEntityList;

  FeedSuccessState(this.feedEntityList);
}

class FeedFailureState extends FeedState {
  final String message;

  FeedFailureState(this.message);
}
