import 'package:flutter/foundation.dart';
import 'package:minha_receita/modules/home/domain/model/comment_entity.dart';
import 'package:minha_receita/modules/home/domain/model/like_entity.dart';
import 'package:minha_receita/modules/home/domain/model/post_entity.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/usecases/post_usecases.dart';
import 'home_states.dart';

class HomeStore {
  final PostUseCases _postUseCases;

  HomeStore({
    required PostUseCases postUseCases,
  }) : _postUseCases = postUseCases;

  BehaviorSubject<PostStates> postState = BehaviorSubject<PostStates>.seeded(
    PostStateLoading(),
  );
  BehaviorSubject<LikesState> likesState = BehaviorSubject<LikesState>.seeded(
    LikesStateInactive(),
  );
  BehaviorSubject<CommentsState> commentsState =
      BehaviorSubject<CommentsState>.seeded(
    CommentsInactive(),
  );

  List<PostEntity> _cachedPostList = [];

  Future<void> getListPosts(int page) async {
    try {
      postState.value = () {
        if (_cachedPostList.isEmpty) {
          return PostStateLoading();
        } else {
          return PostStateLazyLoading(
            postList: _cachedPostList,
          );
        }
      }();
      var postsList = await _postUseCases.getList(page, 3);
      _cachedPostList.addAll(postsList);
      _cachedPostList = _cachedPostList.toSet().toList();
      postState.value = PostStateLoaded(
        postList: _cachedPostList,
      );
    } catch (e) {
      postState.value = PostStateError(
        message: e.toString(),
      );
    }
  }

  Future<String?> onCreateLike(PostEntity post, LikeEntity like) async {
    try {
      postState.value = PostStateLoading();
      await _postUseCases.createLike(post, like);
      postState.value = PostStateLoaded(postList: _cachedPostList);
      return null;
    } catch (e, _) {
      if (kDebugMode) {
        print(e);
        print(_);
      }

      postState.value = PostStateError(
        message: e.toString(),
      );
      return 'Erro ao curtir postagem';
    }
  }

  Future<String?> onCreateComment(
      PostEntity post, CommentEntity comment) async {
    try {
      commentsState.value = CommentOnPostStateLoading(
        postId: post.id,
        commentsList: post.commentsList,
      );
      await _postUseCases.createComment(post, comment);
      postState.value = PostStateLoaded(postList: _cachedPostList);
      return null;
    } catch (e,_) {
      if (kDebugMode) {
        print(e);
        print(_);
      }
      postState.value = PostStateError(
        message: e.toString(),
      );
      return 'Erro ao comentar postagem';
    }
  }

  Future<void> getPostLikes(PostEntity post, int page) async {
    try {
      likesState.value = () {
        if (post.likesList.isEmpty) {
          return LikesStateLoading();
        } else {
          return LikesStateLazyLoading(
            likesList: post.likesList,
          );
        }
      }();

      var likesList = await _postUseCases.getLikes(post, page, 3);
      likesState.value = LikesStateLoaded(
        likesList: likesList,
      );
    } catch (e) {
      likesState.value = LikesStateError(
        message: e.toString(),
      );
    }
  }

  Future<void> getPostComments(PostEntity post, int page) async {
    try {
      commentsState.value = () {
        if (post.commentsList.isEmpty) {
          return CommentsStateLoading();
        } else {
          return CommentsStateLazyLoading(
            commentsList: post.commentsList,
          );
        }
      }();
      await _postUseCases.getComments(post, page, 15);
      commentsState.value = CommentsStateLoaded(
        commentsList: post.commentsList,
      );
    } catch (e) {
      commentsState.value = CommentsStateError(
        message: e.toString(),
      );
    }
  }
}
