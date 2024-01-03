import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tab_bar/tab_bar_view.dart';

enum AppDSBarType { standart, variant1 }

class AppDSAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppDSAppBar({
    super.key,
    this.tabBar,
    this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.drawerMenuLeadingIcon,
    this.onlyLeading = false,
    this.popLeading = false,
    this.type = AppDSBarType.standart,
  });

  final AppDSTabBarView? tabBar;
  final AppDSBarType type;
  final String? title;
  final List<Widget>? actions;
  final bool popLeading;
  final Widget? leading;
  final bool? drawerMenuLeadingIcon;
  final bool onlyLeading;
  final Color? backgroundColor;
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
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Theme.of(context).brightness,
            ),
            backgroundColor: backgroundColor??Theme.of(context).colorScheme.background,
            elevation: 0,
            leading: () {
              if (popLeading) {
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }
              if (leading != null) {
                return leading;
              }
              if (drawerMenuLeadingIcon != null) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                    ));
              }
            }(),
            title: onlyLeading?null:Text(
              title ?? 'Minha Receita',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          if(!onlyLeading)
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
        backgroundColor: backgroundColor??Theme.of(context).colorScheme.primary,
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
