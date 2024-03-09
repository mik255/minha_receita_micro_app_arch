import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_receita/modules/register_recipe/models/recipe_model.dart';
import '../../../../common/services/camera_service.dart';
import '../../services/register_recipe_service.dart';

class PhotoState {}

class PhotoInitialState extends PhotoState {}

class PhotoLoadingState extends PhotoState {}

class PhotoSuccessState extends PhotoState {
  final List<String> files;

  PhotoSuccessState(this.files);
}

class PhotoErrorState extends PhotoState {
  final String message;

  PhotoErrorState(
    this.message,
  );
}

class PhotoCubit extends Cubit<PhotoState> {

  final RegisterRecipeService _service = Modular.get();
  PhotoCubit() : super(PhotoInitialState());

  final List<String> files = [];

  Future<void> addPhoto() async {
    try {
      final file = await CameraService().getMultiImages();
      files.addAll(file);
      emit(PhotoSuccessState(
        files,
      ));
    } catch (e) {
      emit(PhotoErrorState(
        e.toString(),
      ));
    }
  }

  Future<void> removePhoto(String file) async {
    try {
      files.remove(file);
      emit(PhotoSuccessState(
        files,
      ));
    } catch (e) {
      emit(PhotoErrorState(
        e.toString(),
      ));
    }
  }
}
