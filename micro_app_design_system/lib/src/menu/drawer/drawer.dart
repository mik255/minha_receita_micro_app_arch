import 'package:flutter/material.dart';

import '../../avatar/avatar.dart';

class DSDrawerMenu extends StatelessWidget {
  const DSDrawerMenu({
    super.key,
    required this.items,
    required this.avatarImgUrl,
    required this.avatarName,
  });

  final List<Widget> items;
  final String avatarImgUrl;
  final String avatarName;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration:  BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48).copyWith(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: DSAvatar(
                        size: 100,
                        imgUrl: avatarImgUrl,
                        name: avatarName,
                        nameBelowAvatar: true,
                        namePadding: const EdgeInsets.symmetric(vertical: 16),
                        nameStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                  ),
                ],
              ),
            ),
            ...items
          ],
        ),
      ),
    );
  }
}
