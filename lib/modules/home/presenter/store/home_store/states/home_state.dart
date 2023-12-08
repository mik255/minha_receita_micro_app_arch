import 'package:minha_receita/modules/home/domain/model/post_entity.dart';

sealed class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<PostEntity> feedEntityList;

  HomeSuccessState(this.feedEntityList);
}

class HomeFailureState extends HomeState {
  final String message;

  HomeFailureState(this.message);
}
