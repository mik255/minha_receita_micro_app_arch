import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/common/user/domain/models/user.dart';
import 'package:minha_receita/modules/recipe/domain/model/recipe_model.dart';
import 'package:minha_receita/modules/recipe/domain/use_case/post_recipe.dart';

import '../../domain/models/post.dart';
import '../../domain/usecases/post_usecases.dart';
import '../states/post_states.dart';

class PostStore extends ChangeNotifier {
  final PostUseCase postUseCase;
  PostModel postModel = PostModel(
    userId: '',
    description: '',
    recipeId: '',
  );
  PostStore(this.postUseCase);
  var descriptionTextController = TextEditingController();
  PostStates _state = PostInitialState();
  get state => _state;
  Future<bool> postRecipe(String recipeId) async {
    try {
      _state = PostLoadingState();
      postModel.recipeId = recipeId;
      postModel.description = descriptionTextController.text;
      notifyListeners();
      await postUseCase(postModel);
      _state = PostSuccessState();
      notifyListeners();
      return true;
    } catch (e) {
      _state = PostErrorState(e.toString());
      notifyListeners();
      return false;
    }
  }
}
