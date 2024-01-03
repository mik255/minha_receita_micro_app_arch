import 'package:flutter/material.dart';
import 'package:micro_app_account/micro_app_account.dart';
import 'package:micro_app_common/micro_app_common.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'package:micro_app_home/micro_app_home.dart';
import 'modules/post/presenter/routes/post_routes.dart';
import 'modules_injections.dart';
import 'modules/recipe/presenter/routes/recipe_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AppInjections().init();
    CommonNavigator.routes.addAll([
      ...accountRoutes,
      ...homeRoutes,
      ...recipeRoutes,
      ...postRoutes,
    ]);
    DSMaterialThemeSingleton.instance.setTheme(isDark: false);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: DSMaterialThemeSingleton.instance.currentTheme,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: CommonNavigator.navigateKey,
            onGenerateRoute: CommonNavigator.generateRoute,
            theme: DSMaterialThemeSingleton.instance.currentTheme.value,
          );
        });
  }
}
