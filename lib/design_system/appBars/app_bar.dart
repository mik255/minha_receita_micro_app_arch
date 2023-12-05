import 'package:flutter/material.dart';

import '../tab_bar/tab_bar_view.dart';

enum AppDSBarType { standart, variant1 }

class AppDSAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppDSAppBar({
    super.key,
    this.tabBar,
    this.type = AppDSBarType.standart,
    this.title,
    this.actions,
    this.popLeading = false,
  });

  final AppDSTabBarView? tabBar;
  final AppDSBarType type;
  final String? title;
  final List<Widget>? actions;
  final bool popLeading;
  @override
  Widget build(BuildContext context) {
    if (type == AppDSBarType.variant1) {
      return Column(
        children: [
          AppBar(
            scrolledUnderElevation: 0,
            actions: actions,
            bottom: tabBar,
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            leading: !popLeading?null:IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(
              title ?? 'Minha Receita',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          Container(
            height: 0.5,
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      );
    }
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: AppBar(
        bottom: tabBar,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 5,
        title: const Text(
          'Minha Receita',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => () {
        if (type == AppDSBarType.variant1) {
          return const Size.fromHeight(61);
        }
        return const Size.fromHeight(120);
      }();
}
