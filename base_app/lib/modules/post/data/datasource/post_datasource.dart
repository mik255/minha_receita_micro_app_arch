
import '../../../../core/http/core_http.dart';
import '../../domain/models/post.dart';

abstract class PostDataSource {
  Future<void> post(PostModel params);
}

class PostDataSourceImpl implements PostDataSource {
  CoreHttp coreHttp;

  PostDataSourceImpl(this.coreHttp);

  @override
  Future<void> post(PostModel params) async {
    await coreHttp.post(route: '/posts', body: params.toMap());
  }
}
