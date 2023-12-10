import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:minha_receita/design_system/bottons/text_button.dart';
import 'package:minha_receita/modules/common/extensions/scroll_controller.dart';
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

  int page = 1;

  bool _isShowLinearLoading() {
    return store.state is FeedLikesLoadingState && page > 1;
  }

  bool _verifyIfCanLoadMore() {
    return store.state is! FeedLikesLoadingState && page > 0;
  }

  bool _isInitialLoading() {
    return store.state is FeedLikesLoadingState && page == 1;
  }

  @override
  void initState() {
    super.initState();
    store.getPostLikes(widget.postEntity, page);
    _scrollController.onBottomListener(() {
      if (_verifyIfCanLoadMore()) {
        page++;
        store.getPostLikes(widget.postEntity, page);
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
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
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
                    ),
                  ),
                ),
                if (_isShowLinearLoading())
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(),
                  ),
              ],
            );
          }),
    );
  }
}
