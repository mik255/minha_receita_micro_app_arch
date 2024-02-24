import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:minha_receita/modules/home/presenter/componentes/comments_model_content.dart';
import 'package:minha_receita/modules/home/presenter/cubit/comments.dart';
import 'package:minha_receita/modules/home/presenter/cubit/like_cubit.dart';
import 'package:minha_receita/modules/home/presenter/cubit/states/comments_states.dart';
import '../../../../common/components/video_player_component.dart';
import '../../model/post_entity.dart';
import '../../../../common/extensions/string.dart';
import 'likes_model_content.dart';

class FeedCard extends StatefulWidget {
  const FeedCard({
    super.key,
    required this.feedEntity,
  });

  final PostEntity feedEntity;

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> with TickerProviderStateMixin {
  late CommentsCubit commentsCubit;
  late CommentsLoadCubit commentsLoadCubit;

  late LikeLoadCubit likeLoadCubit;
  late LikeCubit likesCubit;

  @override
  void initState() {
    commentsLoadCubit = CommentsLoadCubit(
      Modular.get(),
      postId: widget.feedEntity.id,
    );

    likesCubit = LikeCubit(
      Modular.get(),
      postId: widget.feedEntity.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var space = const SizedBox(height: 8);
    var padding = const EdgeInsets.symmetric(horizontal: 16.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: _avatar(),
        ),
        _carousel(),
        space,
        Padding(
          padding: padding,
          child: _like(),
        ),
        space,
        Padding(
          padding: padding,
          child: _userImgWithLikes(),
        ),
        space,
        Padding(
          padding: padding,
          child: _textDescription(),
        ),
        space,
        Padding(
          padding: padding,
          child: seeCommentsTextButton(),
        ),
        space,
      ],
    );
  }

  Widget _like() {
    return BlocBuilder(
        bloc: likesCubit,
        builder: (context, state) {
          return DSFavoriteButtonIcon(
            onTap: (bool isLiked) async {
              likesCubit.postLike(isLiked);
            },
            isFavorite: true,
          );
        });
  }

  Widget _avatar() {
    var spacer = const SizedBox(width: 8);
    return Row(
      children: [
        DSAvatar(
          imgUrl: widget.feedEntity.avatarImgUrl ??
              'https://i.stack.imgur.com/l60Hf.png',
          name: widget.feedEntity.name,
          date: widget.feedEntity.createdAt?.coreExtensionsConvertToDate(),
        ),
        spacer,
        DSTextButton(
          text: 'Seguir',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _carousel() {
    return Column(
      children: [
        SizedBox(
          height: 275,
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
              controller: TabController(
                  length: widget.feedEntity.imgUrlList.length, vsync: this),
              children: [
                ...widget.feedEntity.imgUrlList.map(
                  (e) => Builder(builder: (context) {
                    var url = e;
                    return Padding(
                      padding:(){
                        if(widget.feedEntity.imgUrlList.first == e){
                          return  const EdgeInsets.only(left: 32);
                        }
                        if (widget.feedEntity.imgUrlList.last == e) {
                          return  const EdgeInsets.only(right: 32);
                        }
                        return const EdgeInsets.only(left: 0);
                      }(),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: () {
                            if (widget.feedEntity.imgUrlList.first == e) {
                              return const BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                bottomLeft: Radius.circular(50.0),
                              );
                            }
                            if (widget.feedEntity.imgUrlList.last == e) {
                              return const BorderRadius.only(
                                topRight: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                              );
                            }
                            return BorderRadius.zero;
                          }(),
                        ),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                )
              ]),
        ),
      ],
    );
  }

  Widget _userImgWithLikes() {
    var likeList = widget.feedEntity.likesList;
    if (likeList.isEmpty) {
      return Container();
    }
    return InkWell(
      onTap: () {
        context.commonExtensionsShowDSModal(
            withScroll: false,
            content: LikesModalContent(
              postId: widget.feedEntity.id,
            ));
      },
      child: Row(
        children: [
          SizedBox(
            width: 48,
            height: 24,
            child: Stack(
              children: [
                if (likeList.length > 1)
                  ...List.generate(
                    2,
                    (index) => Positioned(
                      left: 16 * index.toDouble(),
                      child: DSCustomContainer(
                          height: 24,
                          width: 24,
                          imgURL: likeList[index].urlImg ??
                              'https://i.stack.imgur.com/l60Hf.png'
                          //  "${CommonInjections.baseUrl}/${likeList[index].urlImg}",
                          ),
                    ),
                  )
                else if (likeList.length == 1)
                  DSCustomContainer(
                      height: 24,
                      width: 24,
                      imgURL: likeList[0].urlImg ??
                          'https://i.stack.imgur.com/l60Hf.png'
                      // "${CommonInjections.baseUrl}/${likeList[0].urlImg}",
                      )
              ],
            ),
          ),
          Text(
            '${widget.feedEntity.likesCount} curtidas',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _textDescription() {
    return Text(
      widget.feedEntity.description ?? '',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
    );
  }

  var commentTextController = TextEditingController();
  var focus = FocusNode();

  Widget seeCommentsTextButton() {
    return InkWell(
      onTap: () {
        context.commonExtensionsShowDSModal(
            withScroll: false,
            content: CommentsModalContent(
              postId: widget.feedEntity.id,
            ));
      },
      child: BlocBuilder(
          bloc: commentsLoadCubit,
          builder: (context, state) {
            return Text(
              'Ver todos os ${widget.feedEntity.commentsCount} comentários',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            );
          }),
    );
  }
}
