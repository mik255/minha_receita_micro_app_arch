import 'package:flutter/material.dart';

import '../appBars/app_bar.dart';


class AppDSBasePage extends StatelessWidget {
  const AppDSBasePage({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.appDSAppBar,
    this.floatingActionButton,
  });

  final Widget body;
  final Widget? bottomNavigationBar;
  final AppDSAppBar? appDSAppBar;
  final Widget? floatingActionButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: appDSAppBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar!=null?SafeArea(
        child: bottomNavigationBar!,
      ):null,
    );
  }
}
