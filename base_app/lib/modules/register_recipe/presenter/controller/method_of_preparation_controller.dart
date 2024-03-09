import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_receita/modules/register_recipe/models/step.dart';
import 'package:minha_receita/modules/register_recipe/services/register_recipe_service.dart';

class MethodOfPreparationState {}

class MethodOfPreparationInitialState extends MethodOfPreparationState {}

class MethodOfPreparationLoadingState extends MethodOfPreparationState {}

class MethodOfPreparationErrorState extends MethodOfPreparationState {
  final String message;

  MethodOfPreparationErrorState(this.message);
}

class MethodOfPreparationSuccessState extends MethodOfPreparationState {
  List<MethodOfPreparation> methodOfPreparation = [];

  MethodOfPreparationSuccessState(this.methodOfPreparation);
}

class MethodOfPreparationController extends Cubit<MethodOfPreparationState> {
  final RegisterRecipeService _service = Modular.get();

  MethodOfPreparationController( ) : super(MethodOfPreparationInitialState());

  List<MethodOfPreparation> _methodOfPreparation = [];

  void setMethodOfPreparation(MethodOfPreparation value) {
    _methodOfPreparation = _service.setMethodOfPreparation(value);
    emit(MethodOfPreparationSuccessState(
      _methodOfPreparation,
    ));
  }
}
