import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/design_system/avatar/avatar.dart';
import 'package:minha_receita/modules/common/extensions/string.dart';
import 'package:minha_receita/modules/home/presenter/store/home_states.dart';
import 'package:minha_receita/modules/home/presenter/store/home_store.dart';
import '../../../../design_system/divider/divider.dart';
import '../../../../design_system/modals_contents/list_modal_with_lazy_loading.dart';
import '../../../../modules_injections.dart';
import '../../domain/model/post_entity.dart';

class CommentsModalContent extends StatefulWidget {
  const CommentsModalContent({
    super.key,
    required this.postEntity,
  });

  final PostEntity postEntity;

  @override
  State<CommentsModalContent> createState() => _CommentsModalContentState();
}

class _CommentsModalContentState extends State<CommentsModalContent> {
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  HomeStore get store => GetIt.I.get<HomeStore>();

  @override
  void initState() {
    store.getPostComments(widget.postEntity, page);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: store.commentsState,
        builder: (context, _) {
          var state = store.commentsState.value;
          if (state is CommentsStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CommentsStateError) {
            return const Center(child: Text("Serviço indisponível"));
          }
          state = state as CommentsStateLoaded;
          return DSListModalWithLazyLoading(
            scrollController: _scrollController,
            onLazeLoading: () async {
              page++;
              await store.getPostComments(widget.postEntity, page);
            },
            items: state.commentsList
                .map(
                  (index) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DSAvatar(
                            imgUrl: '${AppInjections.baseUrl}/${index.urlImg}',
                            name: index.name,
                            date: index.createdAt.coreExtensionsConvertToDate(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(index.comment,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                          ),
                        ],
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
