import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_receita/modules/register_recipe/services/register_recipe_service.dart';

class NameDescriptionState {}

class NameDescriptionInitialState extends NameDescriptionState {}

class NameDescriptionLoadingState extends NameDescriptionState {}

class NameDescriptionErrorState extends NameDescriptionState {
  final String message;

  NameDescriptionErrorState(this.message);
}

class NameDescriptionSuccessState extends NameDescriptionState {}

class NameDescriptionController extends Cubit<NameDescriptionState> {
  final RegisterRecipeService _service = Modular.get();

  NameDescriptionController() : super(NameDescriptionInitialState());

  void setName(String name) {
    try {
      _service.setRecipeName(name);
      emit(NameDescriptionSuccessState());
    } catch (e) {
      emit(NameDescriptionErrorState(e.toString()));
    }
  }

  void setDescription(String description) {
    _service.setRecipeDescription(description);
    emit(NameDescriptionSuccessState());
  }
}
