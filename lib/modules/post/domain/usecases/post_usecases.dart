import 'package:minha_receita/modules/post/domain/models/post.dart';
import 'package:minha_receita/modules/post/domain/repository/post_repository.dart';

abstract class PostUseCase {
  Future<void> call(PostModel params);
}

class PostUseCaseImpl implements PostUseCase {
  final PostRepository repository;

  PostUseCaseImpl(this.repository);

  @override
  Future<void> call(PostModel params) async {
    return await repository.post(params);
  }
}
