import 'package:minha_receita/modules/post/domain/models/post.dart';
import 'package:minha_receita/modules/post/domain/repository/post_repository.dart';
import '../datasource/post_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  PostDataSource postDataSource;

  PostRepositoryImpl(this.postDataSource);

  @override
  Future<void> post(PostModel params) {
    return postDataSource.post(params);
  }
}
