import 'package:flutter/material.dart';
import '../tokens/colors/colors.dart';

class AppDSTabBarView extends StatefulWidget implements PreferredSizeWidget{
  const AppDSTabBarView({super.key});

  @override
  State<AppDSTabBarView> createState() => _AppDSTabBarViewState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}

class _AppDSTabBarViewState extends State<AppDSTabBarView>
    with TickerProviderStateMixin {

@override
Widget build(BuildContext context) {
  return TabBar(
    labelColor: AppDSColors.white,
    unselectedLabelColor: AppDSColors.white.withOpacity(0.5),
    //indicatorSize: TabBarIndicatorSize.tab,
    controller: TabController(length: 3, vsync: this),
    tabs: const [
      Tab(
        text: 'Feed',
      ),
      Tab(
        text: 'Top 10',
      ),
      Tab(
        text: 'Perfil',
      ),
    ],
  );
}}
