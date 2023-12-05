import 'package:flutter/material.dart';

class DSPageView extends StatelessWidget {
  const DSPageView({
    super.key,
    required this.pageController,
    required this.children,
  });

  final PageController pageController;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: children,
    );
  }
}
