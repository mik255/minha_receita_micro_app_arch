import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minha_receita/modules/home/domain/model/stories_entity.dart';

import '../../data/repository/home_repository.dart';

class StoriesState {}

class StoriesLoading extends StoriesState {}

class StoriesLoaded extends StoriesState {
  final List<UserStore> stories;

  StoriesLoaded(this.stories);
}

class StoriesError extends StoriesState {
  final String message;

  StoriesError(this.message);
}

class StoriesCubit extends Cubit<StoriesState> {
  final HomeRepository repository;

  StoriesCubit(this.repository) : super(StoriesLoading());

  final List<UserStore> _stories = [];

  int page = 1;

  Future<void> getStories() async {
    try {
      emit(StoriesLoading());
      final response = await repository.getStories(page, 10);
      _stories.addAll(response);
      emit(StoriesLoaded(_stories));
      page++;
    } catch (e,_) {
      print(e.toString());
      print(_.toString());
      emit(StoriesError(e.toString()));
    }
  }
}
