import 'package:flutter/material.dart';

import '../appBars/app_bar.dart';

class AppDSBasePage extends StatelessWidget {
  const AppDSBasePage({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.appDSAppBar,
    this.floatingActionButton,
    this.withScroll = true,
  });

  final Widget body;
  final Widget? bottomNavigationBar;
  final AppDSAppBar? appDSAppBar;
  final Widget? floatingActionButton;
  final bool withScroll;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: appDSAppBar,
      body: () {
        if (withScroll) {
          return SingleChildScrollView(
            child: body,
          );
        }
        return body;
      }(),
      bottomNavigationBar: bottomNavigationBar != null
          ? SafeArea(
              child: bottomNavigationBar!,
            )
          : null,
    );
  }
}
