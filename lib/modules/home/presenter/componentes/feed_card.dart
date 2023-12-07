import 'package:flutter/material.dart';
import 'package:minha_receita/core/extensions/date_extensions.dart';

import '../../../../design_system/bottons/text_button.dart';
import '../../../../design_system/containers/custom_container.dart';
import '../../../../design_system/menu/navigation_menu_bar/item.dart';
import '../../../../design_system/menu/navigation_menu_bar/navigation_menu_bar.dart';
import '../../domain/model/feed_entity.dart';

class FeedCard extends StatefulWidget {
  const FeedCard({
    super.key,
    required this.feedEntity,
    required this.onTap,
  });

  final FeedEntity feedEntity;
  final Function(FeedEntity) onTap;

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
              Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.primary,
              ),
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

  Widget _avatar() {
    var spacer = const SizedBox(width: 8);
    var theme = Theme.of(context);
    return Row(
      children: [
        DSCustomContainer(
          height: 30,
          width: 30,
          backgroundColor: Colors.grey,
          imgURL: widget.feedEntity.imgUrl,
        ),
        spacer,
        Wrap(
          children: [
            Text(
              widget.feedEntity.name,
              style: theme.textTheme.bodySmall
                  ?.copyWith(overflow: TextOverflow.ellipsis,
              color: theme.colorScheme.onSurface
              ),
            ),
          ],
        ),
        spacer,
        Text(
          '• ${widget.feedEntity.createdAt?.convertToDate().lastTime}',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSecondary),
        ),
        spacer,
        DSTextButton(
          text: 'Seguir',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _avatarsLikes() {
    return Row(
      children: [
        SizedBox(
          width: 48,
          child: Stack(
            children: [
              Positioned(
                left: 16,
                child: DSCustomContainer(
                  height: 24,
                  width: 24,
                  imgURL: widget.feedEntity.likesList[0].urlImg,
                ),
              ),
              DSCustomContainer(
                height: 24,
                width: 24,
                imgURL: widget.feedEntity.likesList[1].urlImg,
              )
            ],
          ),
        ),
        Text(
          '${widget.feedEntity.likes} curtidas',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
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
    return Text(
      'Ver todos os ${widget.feedEntity.comments.length} comentários',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
    );
  }
}
