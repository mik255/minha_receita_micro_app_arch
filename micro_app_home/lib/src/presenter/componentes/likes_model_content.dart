import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:micro_app_common/micro_app_common.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
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
                              "${CommonInjections.baseUrl}/${like.urlImg}"),
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
