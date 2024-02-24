import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/modules/home/presenter/cubit/like_cubit.dart';
import 'package:minha_receita/modules/home/presenter/cubit/states/likes_states.dart';
import '../../../../common/injections.dart';
import '../../model/like_entity.dart';

class LikesModalContent extends StatefulWidget {
  const LikesModalContent({super.key, required this.postId});

  final String postId;

  @override
  State<LikesModalContent> createState() => _LikesModalContentState();
}

class _LikesModalContentState extends State<LikesModalContent> {
  late LikeLoadCubit likeLoadCubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    likeLoadCubit = LikeLoadCubit(
      Modular.get(),
      postId: widget.postId,
    );
    likeLoadCubit.loadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: likeLoadCubit,
        builder: (context, state) {

          if (state is LikesLoadError) {
            return const Center(
              child: Text("Serviço indisponível"),
            );
          }
          return DSListModalWithLazyLoading(
            scrollController: _scrollController,
            onLazeLoading: () async {
              await likeLoadCubit.loadLikes();
            },
            items: likeLoadCubit.likes
                .map(
                  (like) => Column(
                    children: [
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.all(0),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(like.urlImg!),
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
