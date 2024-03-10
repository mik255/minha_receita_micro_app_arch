import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/recipe_model.dart';
import '../../services/register_recipe_service.dart';
import '../../services/time_service.dart';

class InfoState {}

class InfoInitialState extends InfoState {}

class InfoLoadingState extends InfoState {}

class InfoErrorState extends InfoState {
  final String message;

  InfoErrorState(this.message);
}

class InfoSuccessState extends InfoState {
  final String timeFormatted;

  InfoSuccessState(this.timeFormatted);
}

class InfoController extends Cubit<InfoState> {
  final RegisterRecipeService _service = Modular.get();

  InfoController() : super(InfoInitialState());

  int timeInMinutes = 0;

  void setTime(int time) {
    try {
      final timeFormatted = TimeService().formatTime(time);
      _service.setTime(time);
      emit(InfoSuccessState(timeFormatted));
    } catch (e) {
      emit(InfoErrorState(e.toString()));
    }
  }

  void setDifficulty(RecipeDificulty difficulty) {
    _service.setDifficulty(difficulty);
  }

  void setStatus(RecipeStatus status) {
    _service.setStatus(status);
  }
}
