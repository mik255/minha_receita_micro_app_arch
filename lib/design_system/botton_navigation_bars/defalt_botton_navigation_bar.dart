import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.onTap,
    required this.items,
  });

  final List<BottomNavigationBarItem> items;
  final Function(int) onTap;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  void onSelected(int index) {
    setState(() {
      currentIndex = index;
      widget.onTap(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      currentIndex: currentIndex,
      onTap: onSelected,
      items: widget.items,
    );
  }
}
