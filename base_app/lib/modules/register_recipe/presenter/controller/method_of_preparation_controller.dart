import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_receita/modules/register_recipe/models/step.dart';
import 'package:minha_receita/modules/register_recipe/services/register_recipe_service.dart';

import '../../../../common/services/camera_service.dart';

class MethodOfPreparationDTO {
  MethodOfPreparation methodOfPreparation = MethodOfPreparation(
    description: '',
    step: 0,
  );
  TextEditingController controller = TextEditingController();

  List<String> imgBase64 = [];

  MethodOfPreparationDTO({
    required int step,
  }) {
    methodOfPreparation.step = step;
    methodOfPreparation.description = controller.text;
  }
}

class MethodOfPreparationState {}

class MethodOfPreparationInitialState extends MethodOfPreparationState {}

class MethodOfPreparationLoadingState extends MethodOfPreparationState {}

class MethodOfPreparationErrorState extends MethodOfPreparationState {
  final String message;

  MethodOfPreparationErrorState(this.message);
}

class MethodOfPreparationSuccessState extends MethodOfPreparationState {
  List<MethodOfPreparationDTO> methodOfPreparation = [];

  MethodOfPreparationSuccessState(this.methodOfPreparation);
}

class MethodOfPreparationCubit extends Cubit<MethodOfPreparationState> {
  final RegisterRecipeService _service = Modular.get();

  MethodOfPreparationCubit() : super(MethodOfPreparationInitialState());

  final List<MethodOfPreparationDTO> _methodOfPreparation = [];

  void setDescMethodOfPreparation(int index, String description) {
    _methodOfPreparation[index].methodOfPreparation.description = description;
    _service.updateMethodOfPreparationDescription(
      _methodOfPreparation[index].methodOfPreparation,
    );
    emit(MethodOfPreparationSuccessState(
      _methodOfPreparation,
    ));
  }

  void setMethodOfPreparation() {
    final dto = MethodOfPreparationDTO(
      step: _methodOfPreparation.length + 1,
    );
    _methodOfPreparation.add(dto);
    _service.setMethodOfPreparation(
      dto.methodOfPreparation,
    );
    emit(MethodOfPreparationSuccessState(
      _methodOfPreparation,
    ));
  }

  void removeMethodOfPreparation(int index) {
    _methodOfPreparation.removeAt(index);
    _methodOfPreparation.sort((a, b) =>
        a.methodOfPreparation.step.compareTo(b.methodOfPreparation.step));
    _methodOfPreparation.asMap().forEach((index, element) {
      element.methodOfPreparation.step = index + 1;
    });
    emit(MethodOfPreparationSuccessState(
      _methodOfPreparation,
    ));
  }

  void setPhotoMethodOfPreparation(int index) async {
    final file = await CameraService().getMultiImages();
    _methodOfPreparation[index].imgBase64.addAll(file);
    emit(MethodOfPreparationSuccessState(
      _methodOfPreparation,
    ));
  }

  void photoRemoveMethodOfPreparation(int index) {
    _methodOfPreparation[index].imgBase64.removeAt(index);
    emit(MethodOfPreparationSuccessState(
      _methodOfPreparation,
    ));
  }
}
