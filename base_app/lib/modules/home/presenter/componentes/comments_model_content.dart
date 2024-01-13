import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/common/extensions/string.dart';
import '../../../../common/injections.dart';
import '../../domain/model/post_entity.dart';
import '../store/home_states.dart';
import '../store/home_store.dart';

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
                            imgUrl:
                                '${CommonInjections.baseUrl}/${index.urlImg}',
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
