import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:minha_receita/design_system/bottons/text_button.dart';

import '../../../../design_system/divider/divider.dart';

import '../../../../design_system/modals_contents/list_modal_with_lazy_loading.dart';
import '../../../../modules_injections.dart';
import '../../domain/model/post_entity.dart';
import '../store/home_states.dart';
import '../store/home_store.dart';

class LikesModalContent extends StatefulWidget {
  const LikesModalContent({super.key, required this.postEntity});

  final PostEntity postEntity;

  @override
  State<LikesModalContent> createState() => _LikesModalContentState();
}

class _LikesModalContentState extends State<LikesModalContent> {
  HomeStore get store => GetIt.I.get<HomeStore>();
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    store.getPostLikes(widget.postEntity, page);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: store.likesState,
        builder: (context, _) {
          var state = store.likesState.value;
          if (state is LikesStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LikesStateError) {
            return const Center(
              child: Text("Serviço indisponível"),
            );
          }
          state = state as LikesStateLoaded;
          return DSListModalWithLazyLoading(
            scrollController: _scrollController,
            onLazeLoading: () async {
              page++;
              await store.getPostLikes(widget.postEntity, page);
            },
            items: state.likesList
                .map(
                  (like) => Column(
                    children: [
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.all(0),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${AppInjections.baseUrl}/${like.urlImg}"),
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
                )
                .toList(),
          );
        });
  }
}
