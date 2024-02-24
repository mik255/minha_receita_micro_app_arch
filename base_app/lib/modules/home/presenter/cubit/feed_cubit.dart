import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minha_receita/modules/home/data/repository/home_repository.dart';
import '../../model/post_entity.dart';

class FeedStates {}

class FeedInitial extends FeedStates {}

class FeedLoading extends FeedStates {}

class FeedLoaded extends FeedStates {
  final List<PostEntity> feed;

  FeedLoaded(this.feed);
}

class FeedError extends FeedStates {}

class FeedCubit extends Cubit<FeedStates> {
  final HomeRepository homeRepository;

  FeedCubit(this.homeRepository) : super(FeedLoading());

  final List<PostEntity> _feed = [];
  int page = 1;
  Future<void> getFeed() async {
    try {
      emit(FeedLoading());
      _feed.addAll(await homeRepository.getListPost(page, 10));
      emit(FeedLoaded(_feed));
      page++;
    } on Exception {
      emit(FeedError());
    }
  }
}
