import 'package:flutter/material.dart';

import '../snack_bar/sack_bar.dart';

class DSFavoriteButtonIcon extends StatefulWidget {
  const DSFavoriteButtonIcon(
      {super.key, required this.onTap, required this.isFavorite});

  final Function(bool) onTap;
  final bool isFavorite;

  @override
  State<DSFavoriteButtonIcon> createState() => _DSFavoriteButtonIconState();
}

class _DSFavoriteButtonIconState extends State<DSFavoriteButtonIcon> {
  late bool userLiked = () {
    return widget.isFavorite;
  }();

  void onTap() {
    setState(() {
      userLiked = !userLiked;
    });
    widget.onTap(userLiked);
    ScaffoldMessenger.of(context).showSnackBar(
      DSSnackBar(
        message: userLiked
            ? 'Você curtiu essa receita'
            : 'Você descurtiu essa receita',
      ).build,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        userLiked ? Icons.favorite : Icons.favorite_border_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
