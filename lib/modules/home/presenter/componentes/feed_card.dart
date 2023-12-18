import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_receita/modules/common/extensions/context.dart';
import 'package:minha_receita/modules/common/extensions/string.dart';
import 'package:video_player/video_player.dart';
import '../../../../design_system/avatar/avatar.dart';
import '../../../../design_system/bottons/text_button.dart';
import '../../../../design_system/containers/custom_container.dart';
import '../../../../design_system/icon/favorite.dart';
import '../../../../design_system/menu/navigation_menu_bar/item.dart';
import '../../../../design_system/menu/navigation_menu_bar/navigation_menu_bar.dart';
import '../../../../modules_injections.dart';
import '../../../recipe/presenter/components/video_player_component.dart';
import '../../domain/model/post_entity.dart';
import '../store/feed_store/feed_store.dart';
import 'comments_model_content.dart';
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

class _FeedCardState extends State<FeedCard> {
  late ValueNotifier<bool> userLikedNotifier = () {
    return ValueNotifier(widget.feedEntity.userLiked);
  }();
  var store = GetIt.I.get<FeedStore>();

  @override
  Widget build(BuildContext context) {
    var space = const SizedBox(height: 8);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _avatar(),
        ),
        _carousel(),
        space,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _like(),
        ),
        space,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _avatarsLikes(),
        ),
        space,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _textDescription(),
        ),
        space,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: seeCommentsTextButton(),
        ),
        space,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _textInputComment(),
        )
      ],
    );
  }

  Widget _like() {
    return DSFavoriteButtonIcon(
      onTap: (bool isLiked) {
        widget.feedEntity.userLiked = isLiked;
        store.onLikedEvent(widget.feedEntity, isLiked);
      },
      userLiked: widget.feedEntity.userLiked,
    );
  }

  Widget _avatar() {
    var spacer = const SizedBox(width: 8);
    return Row(
      children: [
        DSAvatar(
          imgUrl: '${AppInjections.baseUrl}/${widget.feedEntity.avatarImgUrl}',
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
      height: 300,
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
                    var url = "${AppInjections.baseUrl}/$e";
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

  Widget _avatarsLikes() {
    var likeList = widget.feedEntity.likesList;
    if (likeList.isEmpty) {
      return Container();
    }
    return InkWell(
      onTap: () {
        context.commonExtensionsShowDSModal(
            withScroll: false,
            content: LikesModalContent(
              postEntity: widget.feedEntity,
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
                        imgURL:
                            "${AppInjections.baseUrl}/${likeList[index].urlImg}",
                      ),
                    ),
                  )
                else if (likeList.length == 1)
                  DSCustomContainer(
                    height: 24,
                    width: 24,
                    imgURL: "${AppInjections.baseUrl}/${likeList[0].urlImg}",
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
            decoration: InputDecoration(
              hintText: 'Adicione um comentário...',
              hintStyle: Theme.of(context).textTheme.bodySmall,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(width: 8),
        DSTextButton(
          text: 'Publicar',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget seeCommentsTextButton() {
    return InkWell(
      onTap: () {
        context.commonExtensionsShowDSModal(
            withScroll: false,
            content: CommentsModalContent(
              postEntity: widget.feedEntity,
            ));
      },
      child: Text(
        'Ver todos os ${widget.feedEntity.commentsCount} comentários',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
    );
  }
}
