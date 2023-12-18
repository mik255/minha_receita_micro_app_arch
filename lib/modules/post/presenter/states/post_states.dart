abstract class PostStates {}

class PostInitialState extends PostStates {}

class PostLoadingState extends PostStates {}

class PostSuccessState extends PostStates {}

class PostErrorState extends PostStates {
  final String message;

  PostErrorState(this.message);
}
