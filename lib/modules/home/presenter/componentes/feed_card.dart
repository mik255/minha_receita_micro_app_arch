import 'package:flutter/material.dart';
import 'package:minha_receita/core/extensions/string.dart';
import '../../../../design_system/avatar/avatar.dart';
import '../../../../design_system/bottons/text_button.dart';
import '../../../../design_system/containers/custom_container.dart';
import '../../../../design_system/menu/navigation_menu_bar/item.dart';
import '../../../../design_system/menu/navigation_menu_bar/navigation_menu_bar.dart';
import '../../domain/model/comment_entity.dart';
import '../../domain/model/post_entity.dart';
import '../../domain/model/like_entity.dart';

class FeedCard extends StatefulWidget {
  const FeedCard({
    super.key,
    required this.feedEntity,
    required this.onTap,
    required this.onTapSeeAllComments,
    required this.onTapLikes,
  });

  final PostEntity feedEntity;
  final Function(PostEntity) onTap;
  final Function(List<LikeEntity> likesList) onTapLikes;
  final Function(List<CommentEntity> listComments) onTapSeeAllComments;

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    var space = const SizedBox(height: 8);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _avatar(),
              _carousel(),
              space,
              _iconFavorite(),
              space,
              _avatarsLikes(),
              space,
              _textDescription(),
              space,
              seeCommentsTextButton(),
              space,
              _textInputComment()
            ],
          ),
        ),
      ],
    );
  }

  Widget _iconFavorite() {
    return Icon(
      Icons.favorite,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _avatar() {
    var spacer = const SizedBox(width: 8);
    return Row(
      children: [
        DSAvatar(
          imgUrl: widget.feedEntity.avatarImgUrl,
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
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.feedEntity);
      },
      child: DSNavigationMenuBar(
        dsNavigationMenuBarVariants: DSNavigationMenuBarVariants.carousel,
        items: [
          ...widget.feedEntity.recipeImgUrlList
              .map((e) => DSNavigationMenuBarItem(
                    customContainer: DSCustomContainer(
                      // description: e.description,
                      descriptionPadding: const EdgeInsets.all(8),
                      imgURL: e,
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.9,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  )),
        ],
        onTap: (int index) {},
      ),
    );
  }

  Widget _avatarsLikes() {
    var likeList = widget.feedEntity.likesList;
    if (likeList.isEmpty) {
      return Container();
    }
    return InkWell(
      onTap: () => widget.onTapLikes(likeList),
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
                        imgURL: likeList[index].urlImg,
                      ),
                    ),
                  )
                else if (likeList.length == 1)
                  DSCustomContainer(
                    height: 24,
                    width: 24,
                    imgURL: likeList[0].urlImg,
                  )
              ],
            ),
          ),
          Text(
            '${likeList.length-1} curtidas',
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
      onTap: () => widget.onTapSeeAllComments(widget.feedEntity.comments),
      child: Text(
        'Ver todos os ${widget.feedEntity.comments.length} comentários',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
    );
  }
}
