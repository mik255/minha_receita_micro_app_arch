import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_receita/modules/register_recipe/services/register_recipe_service.dart';

class RegisterRecipeState {}

class RegisterRecipeInitialState extends RegisterRecipeState {}

class RegisterRecipeLoadingState extends RegisterRecipeState {}

class RegisterRecipeErrorState extends RegisterRecipeState {
  final String message;

  RegisterRecipeErrorState(this.message);
}

class RegisterRecipeController extends Cubit<RegisterRecipeState> {
  final RegisterRecipeService _service = Modular.get();

  RegisterRecipeController() : super(RegisterRecipeInitialState());

  void saveRecipe() async {
    try {
      emit(RegisterRecipeLoadingState());
      await _service.registerRecipe();
      _service.clear();
      emit(RegisterRecipeInitialState());
    } catch (e) {
      emit(RegisterRecipeErrorState(e.toString()));
    }
  }
}
