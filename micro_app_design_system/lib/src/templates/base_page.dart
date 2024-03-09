import 'package:flutter/material.dart';

import '../appBars/app_bar.dart';

class AppDSBasePage extends StatefulWidget {
  const AppDSBasePage({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.appDSAppBar,
    this.drawer,
    this.floatingActionButton,
    this.withScroll = true,
  });

  final Widget body;
  final Widget? bottomNavigationBar;
  final AppDSAppBar? appDSAppBar;
  final Widget? floatingActionButton;
  final bool withScroll;
  final Widget? drawer;

  @override
  State<AppDSBasePage> createState() => _AppDSBasePageState();
}

class _AppDSBasePageState extends State<AppDSBasePage> {

  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: widget.floatingActionButton,
        appBar: widget.appDSAppBar,
        body: () {
          if (widget.withScroll) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: widget.body,
              ),
            );
          }
          return widget.body;
        }(),
        drawer: widget.drawer,
        bottomNavigationBar: widget.bottomNavigationBar != null
            ? SafeArea(
                child: widget.bottomNavigationBar!,
              )
            : null,
      ),
    );
  }
}
