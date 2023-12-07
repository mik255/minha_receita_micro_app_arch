import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'item.dart';

enum DSNavigationMenuBarVariants { horizontalList, carousel }

class DSNavigationMenuBar extends StatefulWidget {
  const DSNavigationMenuBar({
    super.key,
    required this.items,
    required this.onTap,
    this.title,
    this.horizontalSpacing,
    this.dsNavigationMenuBarVariants =
        DSNavigationMenuBarVariants.horizontalList,
  });

  final Widget? title;
  final List<DSNavigationMenuBarItem> items;
  final void Function(int index) onTap;
  final DSNavigationMenuBarVariants? dsNavigationMenuBarVariants;
  final double? horizontalSpacing;
  @override
  State<DSNavigationMenuBar> createState() => _DSNavigationMenuBarState();
}

class _DSNavigationMenuBarState extends State<DSNavigationMenuBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            child: widget.title,
          ),
        if (widget.dsNavigationMenuBarVariants ==
            DSNavigationMenuBarVariants.horizontalList)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...widget.items.map((e) => Padding(
                      padding:  EdgeInsets.only(right: widget.horizontalSpacing ?? 8),
                      child: GestureDetector(
                        onTap: () {
                          widget.onTap(widget.items.indexOf(e));
                        },
                        child: e,
                      ),
                    ))
              ],
            ),
          )
        else
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                    pageSnapping: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                    height: 275.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    onPageChanged: (index, reason) {
                      currentIndex = index;
                      setState(() {});
                    }),
                items: widget.items.map((e) {
                  return Builder(
                    builder: (BuildContext context) => e,
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.items.map((e) {
                  final int index = widget.items.indexOf(e);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? Theme.of(context).colorScheme.primary
                          : const Color(0xFFD8D8D8).withOpacity(0.5),
                    ),
                  );
                }).toList(),
              ),
            ],
          )
      ],
    );
  }
}
