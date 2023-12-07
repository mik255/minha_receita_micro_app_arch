import 'package:flutter/material.dart';

class AppDSCardWithImage extends StatelessWidget {
  const AppDSCardWithImage({
    super.key,
    this.borderRadius = 0,
    this.elevation = 0,
    this.imageUrl,
    this.onTap,
  });

  final double borderRadius;
  final String? imageUrl;
  final double elevation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            if (elevation > 0)
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              )
          ]),
      child: Stack(
        children: [
          if (imageUrl != null)
            Image.network(
              imageUrl!,
              fit: BoxFit.cover,
            )
          else
            InkWell(
              onTap: onTap,
              child: const Center(
                child: Icon(Icons.add_a_photo_outlined),
              ),
            )
        ],
      ),
    );
  }
}
