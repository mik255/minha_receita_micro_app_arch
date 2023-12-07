import 'package:flutter/material.dart';
import 'package:minha_receita/core/extensions/string.dart';
import 'package:minha_receita/design_system/avatar/avatar.dart';
import 'package:minha_receita/modules/home/domain/model/comment_entity.dart';

import '../../../../design_system/divider/divider.dart';

class CommentsModalContent extends StatelessWidget {
  const CommentsModalContent({super.key, required this.listComments});

  final List<CommentEntity> listComments;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          ...listComments.map(
            (index) => Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DSAvatar(
                      imgUrl: index.urlImg,
                      name: index.name,
                      date: index.createdAt.coreExtensionsConvertToDate(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(index.comment,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                    ),
                  ],
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
