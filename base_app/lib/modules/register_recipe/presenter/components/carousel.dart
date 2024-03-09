import 'dart:convert';
import 'package:flutter/material.dart';

class DSCarousel extends StatefulWidget {
  const DSCarousel({
    Key? key,
    required this.recipeImgUrlList,
    required this.pageController,
    this.base64ImgList = const [],
    this.widgets = const [],
    this.onTap,
  }) : super(key: key);
  final List<String> recipeImgUrlList;
  final List<String> base64ImgList;

  final List<Widget> widgets;
  final PageController pageController;

  final void Function(int index)? onTap;

  @override
  State<DSCarousel> createState() => _DSCarouselState();
}

class _DSCarouselState extends State<DSCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView(
            physics: const BouncingScrollPhysics(),
            controller: widget.pageController,
            children: [
              for (var i = 0; i < widget.recipeImgUrlList.length; i++)
                InkWell(
                  onTap: () {
                    widget.onTap?.call(i);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 250,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.recipeImgUrlList[i]),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              for (var i = 0; i < widget.base64ImgList.length; i++)
                InkWell(
                  onTap: () {
                    widget.onTap?.call(i);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 250,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: MemoryImage(
                          base64.decode(widget.base64ImgList[i]),
                        ),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ...widget.widgets,
            ],
          ),
        ),
        //bullets
        AnimatedBuilder(
            animation: widget.pageController,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0;
                        i <
                            widget.recipeImgUrlList.length +
                                widget.base64ImgList.length +
                                widget.widgets.length;
                        i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: () {
                            try {
                              return (widget.pageController.page
                                              ?.round()
                                              .toInt() ??
                                          0) ==
                                      i
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurface;
                            } catch (e) {
                              return Theme.of(context).colorScheme.primary;
                            }
                          }(),
                        ),
                      ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
