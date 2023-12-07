import 'package:flutter/material.dart';
import 'package:minha_receita/design_system/bottons/text_button.dart';

import '../../../../design_system/divider/divider.dart';
import '../../domain/model/like_entity.dart';

class LikesModalContent extends StatelessWidget {
  const LikesModalContent({super.key, required this.likesList});
  final List<LikeEntity> likesList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ...likesList.map(
            (like) => Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(like.urlImg),
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
        ],
      ),
    );
  }
}
