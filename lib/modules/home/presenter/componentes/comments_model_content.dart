import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/design_system/avatar/avatar.dart';
import 'package:minha_receita/modules/common/extensions/string.dart';
import 'package:minha_receita/modules/home/presenter/store/comments_store/comments_store.dart';

import '../../../../design_system/divider/divider.dart';
import '../../../../design_system/modals_contents/list_modal_with_lazy_loading.dart';
import '../../domain/model/post_entity.dart';
import '../store/comments_store/states/comments_states.dart';

class CommentsModalContent extends StatefulWidget {
  const CommentsModalContent({super.key, required this.postEntity});

  final PostEntity postEntity;

  @override
  State<CommentsModalContent> createState() => _CommentsModalContentState();
}

class _CommentsModalContentState extends State<CommentsModalContent> {
  CommentsStore get store => GetIt.I.get<CommentsStore>();
  final ScrollController _scrollController = ScrollController();

  int page = 1;

  bool _isInitialLoading() {
    return store.state is CommentLoadingState && page == 1;
  }

  @override
  void initState() {
    super.initState();
    store.getPostComments(widget.postEntity, page);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          if (_isInitialLoading()) {
            return const Center(child: CircularProgressIndicator());
          }
          if (store.state is CommentFailureState) {
            return const Center(child: Text("Serviço indisponível"));
          }
          return DSListModalWithLazyLoading(
            scrollController: _scrollController,
            onLazeLoading: () async {
              page++;
              await store.getPostComments(widget.postEntity, page);
            },
            items: [],
            // items: widget.postEntity.comments
            //     .map(
            //       (index) => Column(
            //         children: [
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               DSAvatar(
            //                 imgUrl: index.urlImg,
            //                 name: index.name,
            //                 date: index.createdAt.coreExtensionsConvertToDate(),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(vertical: 16.0),
            //                 child: Text(index.comment,
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .bodySmall
            //                         ?.copyWith(
            //                             color: Theme.of(context)
            //                                 .colorScheme
            //                                 .secondary)),
            //               ),
            //             ],
            //           ),
            //           const DSDivider(),
            //         ],
            //       ),
            //     )
            //     .toList(),
          );
        });
  }
}
