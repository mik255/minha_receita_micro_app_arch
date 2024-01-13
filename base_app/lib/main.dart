import 'package:flutter/material.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'common/navigator/navigator.dart';
import 'modules/account/presenter/routes/account_routes.dart';
import 'modules/home/presenter/routes/home_routes.dart';
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
    return AnimatedBuilder(
        animation: DSMaterialThemeSingleton.instance.currentTheme,
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
