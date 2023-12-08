import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/core/extensions/scroll_controller.dart';
import 'package:minha_receita/design_system/bottons/text_button.dart';
import 'package:minha_receita/modules/home/domain/model/post_entity.dart';
import 'package:minha_receita/modules/home/presenter/store/likes_store/likes_store.dart';

import '../../../../design_system/divider/divider.dart';

import '../store/likes_store/states/likes_states.dart';

class LikesModalContent extends StatefulWidget {
  const LikesModalContent({super.key, required this.postEntity});

  final PostEntity postEntity;

  @override
  State<LikesModalContent> createState() => _LikesModalContentState();
}

class _LikesModalContentState extends State<LikesModalContent> {
  LikesStore get store => GetIt.I.get<LikesStore>();
  final ScrollController _scrollController = ScrollController();

  int get count => store.getFeedLikesUseCase.count;

  bool _verifyIfCanLoadMore() {
    return store.state is! FeedLikesLoadingState && count > 0;
  }

  bool _isInitialLoading() {
    return store.state is FeedLikesLoadingState && count == 0;
  }

  @override
  void initState() {
    super.initState();
    store.getPostLikes(widget.postEntity);
    _scrollController.onBottomListener(() {
      if (_verifyIfCanLoadMore()) {
        store.getPostLikes(widget.postEntity);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListenableBuilder(
          listenable: store,
          builder: (context, _) {
            if (_isInitialLoading()) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                if (_verifyIfCanLoadMore())
                  const Center(
                    child: LinearProgressIndicator(),
                  ),
                ...widget.postEntity.likesList.map(
                  (like) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(like.urlImg),
                        ),
                        title: Text(like.name),
                        subtitle: Text(like.description),
                        trailing: DSTextButton(
                          text: 'Seguir',
                          onPressed: () {},
                        ),
                      ),
                      const DSDivider(),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
