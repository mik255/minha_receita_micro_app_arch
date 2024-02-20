import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import '../../../../common/components/video_player_component.dart';
import '../../../../common/injections.dart';
import '../../domain/model/comment_entity.dart';
import '../../domain/model/like_entity.dart';
import '../../domain/model/post_entity.dart';
import '../../../../common/extensions/string.dart';

class FeedCard extends StatefulWidget {
  const FeedCard({
    super.key,
    required this.feedEntity,
  });

  final PostEntity feedEntity;

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
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
        Padding(
          padding: padding,
          child: _textInputComment(),
        )
      ],
    );
  }

  Widget _like() {
    return DSFavoriteButtonIcon(
      onTap: (bool isLiked) async {
        // String? hasError = await () async {
        //   if (isLiked) {
        //     LikeEntity like = LikeEntity(
        //       id: '',
        //       autorUserId: user.id!,
        //       urlImg: user.avatarImgUrl ??
        //           'https://i.stack.imgur.com/l60Hf.png',
        //       name: user.name!,
        //       description: '',
        //       isFallowing: isLiked,
        //     );
        //     return await store.onCreateLike(widget.feedEntity, like);
        //   }
        //   var like = widget.feedEntity.likesList.firstWhere(
        //         (element) => element.autorUserId == user.id,
        //   );
        //   return await store.onRemoveLike(widget.feedEntity, like);
        // }();
        // if (hasError != null) {
        //   // ignore: use_build_context_synchronously
        //   context.commonExtensionsShowDSModal(
        //     content: DSModal(
        //       dsModalVariants: DSModalVariants.optionsModal,
        //       title: 'Erro',
        //       subtitle: hasError,
        //       buttons: [
        //         DSTextButton(
        //           text: 'Ok',
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ],
        //     ),
        //   );
        //   return;
        // }
      },
      isFavorite: true,
    );
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
    return DSNavigationMenuBar(
      height: 350,
      dsNavigationMenuBarVariants: DSNavigationMenuBarVariants.carousel,
      items: [
        ...widget.feedEntity.imgUrlList.map((e) => DSNavigationMenuBarItem(
              customContainer: DSCustomContainer(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  descriptionPadding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                  ),
                  child: Builder(builder: (context) {
                    String extension = e.split('.').last.toLowerCase();
                    var url = e;
                    if (extension == 'mp4') {
                      return SizedBox(
                        height: 250,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: VideoPlayerWidget(url: url),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Image.network(
                      url,
                      fit: BoxFit.cover,
                    );
                  })),
            )),
      ],
      onTap: (int index) {},
    );
  }

  Widget _userImgWithLikes() {
    var likeList = widget.feedEntity.likesList;
    if (likeList.isEmpty) {
      return Container();
    }
    return InkWell(
      onTap: () {
        // context.commonExtensionsShowDSModal(
        //     withScroll: false,
        //     content: LikesModalContent(
        //       postEntity: widget.feedEntity,
        //     ));
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

  Widget _textInputComment() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: TextEditingController(),
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Adicione um comentário...',
              hintStyle: Theme.of(context).textTheme.bodySmall,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Builder(builder: (context) {
          return DSTextButton(
            text: 'Publicar',
            onPressed: () async {},
          );
        }),
      ],
    );
  }

  Widget seeCommentsTextButton() {
    return InkWell(
      onTap: () {},
      child: Text(
        'Ver todos os ${widget.feedEntity.commentsCount} comentários',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
    );
  }
}
