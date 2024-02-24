import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/common/extensions/string.dart';
import 'package:minha_receita/modules/home/presenter/cubit/comments.dart';
import 'package:minha_receita/modules/home/presenter/cubit/states/comments_states.dart';
import '../../../../common/injections.dart';

class CommentsModalContent extends StatefulWidget {
  const CommentsModalContent({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<CommentsModalContent> createState() => _CommentsModalContentState();
}

class _CommentsModalContentState extends State<CommentsModalContent>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late CommentsLoadCubit commentsLoadCubit;

  late CommentsCubit commentsCubit;

  @override
  void initState() {
    commentsCubit = CommentsCubit(
      Modular.get(),
      postId: widget.postId,
    );
    commentsLoadCubit = CommentsLoadCubit(
      Modular.get(),
      postId: widget.postId,
    );

    commentsLoadCubit.loadComments();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: commentsLoadCubit,
        builder: (context, state) {
          if (state is CommentsLoadError) {
            return const Center(child: Text("Serviço indisponível"));
          }

          return FadeTransition(
            opacity: AnimationController(
              vsync: this,
              duration: const Duration(seconds: 1),
            )..drive(
              Tween<double>(begin: 0, end: 1),
            )..forward(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: MediaQuery.of(context).viewInsets,
              child: Stack(
                children: [
                  DSListModalWithLazyLoading(
                    scrollController: _scrollController,
                    onLazeLoading: () async {
                      await commentsLoadCubit.loadComments();
                    },
                    items: commentsLoadCubit.commentsList
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
                                    imgUrl: index.urlImg,
                                    name: index.name,
                                    date: index.createdAt
                                        .coreExtensionsConvertToDate(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
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
                  ),
                  _textInputComment()
                ],
              ),
            ),
          );
        });
  }

  var focus = FocusNode();
  var commentTextController = TextEditingController();

  Widget _textInputComment() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            color: Colors.white,
            child: BlocBuilder(
                bloc: commentsCubit,
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: AppDSTextField(
                          focusNode: focus,
                          // readOnly: () {
                          //   if (state is PostCommentSuccess) {
                          //     commentsLoadCubit.addComment(
                          //       commentTextController.text,
                          //       'name',
                          //       'imgUrl',
                          //     );
                          //     commentTextController.text = '';
                          //     focus.unfocus();
                          //   }
                          //   if (state is PostCommentInitial) {
                          //     commentTextController.text = '';
                          //     focus.unfocus();
                          //   }
                          //   if (state is PostCommentLoading) {
                          //     return true;
                          //   }
                          //   return false;
                          // }(),
                          controller: commentTextController,
                          maxLines: null,
                          // decoration: InputDecoration(
                          //   hintText: 'Adicione um comentário...',
                          //   hintStyle: Theme.of(context).textTheme.bodySmall,
                          //   border: InputBorder.none,
                          // ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Builder(builder: (context) {
                        if (state is PostCommentLoading) {
                          return const SizedBox(
                              height: 56,
                              width: 56,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ));
                        }
                        return DSTextButton(
                          text: 'Publicar',
                          onPressed: () async {
                            commentsCubit
                                .postComment(commentTextController.text);
                          },
                        );
                      }),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
