import 'package:flutter/material.dart';

class DSCustomContainer extends StatelessWidget {
  const DSCustomContainer({
    super.key,
    this.iconData,
    this.imgURL,
    this.backgroundColor,
    this.shape,
    this.height,
    this.width,
    this.iconColor,
    this.description,
    this.descriptionPadding,
    this.iconPadding,
    this.child,
    this.leadingText,
    this.circularRadius,
    this.shadows = false,
    this.borderSide,
    this.image
  });

  final IconData? iconData;
  final Color? iconColor;
  final String? imgURL;
  final Color? backgroundColor;
  final ShapeBorder? shape;
  final double? height;
  final double? width;
  final String? description;
  final String? leadingText;
  final EdgeInsetsGeometry? descriptionPadding;
  final EdgeInsetsGeometry? iconPadding;
  final Widget? child;
  final double? circularRadius;
  final bool shadows;
  final BorderSide? borderSide;
  final DecorationImage? image;
  @override
  Widget build(BuildContext context) {
    var height = this.height;
    var width = this.width;
    return Container(
        clipBehavior: Clip.antiAlias,
        height: circularRadius ?? height,
        width: circularRadius ?? width,
        decoration: ShapeDecoration(
            image:image,
            color: backgroundColor ?? Theme.of(context).colorScheme.surface,
            shape: shape ??
                OvalBorder(
                  side: borderSide ?? BorderSide.none,
                ),
            shadows: [
              if (shadows)
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
            ]),
        child: Stack(
          children: [
            if (iconData != null || leadingText != null)
              Center(
                child: Container(
                  padding: iconPadding,
                  child: leadingText != null
                      ? Text(
                          leadingText!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.background,
                          ),
                        )
                      : Icon(
                          size: height != null ? (height * 0.6) : null,
                          iconData,
                          color:
                              iconColor ?? Theme.of(context).colorScheme.shadow,
                        ),
                ),
              )
            else if (imgURL != null)
              Center(
                child: Image.network(
                  height: height,
                  width: width,
                  imgURL!,
                  fit: BoxFit.cover,
                ),
              ),
            if (description != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: descriptionPadding,
                          height: height != null ? (height * 0.2) : null,
                          color: Colors.black.withOpacity(0.4),
                          child: Center(
                            child: Text(
                              description ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            if (child != null) child!,
          ],
        ));
  }
}
