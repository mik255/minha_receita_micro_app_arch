

import '../models/post.dart';

abstract class PostRepository {
  Future<void> post(PostModel params);
}