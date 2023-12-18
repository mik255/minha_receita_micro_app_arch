import 'package:flutter/material.dart';
import 'modules/account/presenter/pages/login_page.dart';
import 'modules/account/presenter/routes/account_routes.dart';
import 'modules/common/navigator/navigator.dart';
import 'modules/post/presenter/routes/post_routes.dart';
import 'modules_injections.dart';

import 'design_system/themes.dart';
import 'modules/home/presenter/routes/home_routes.dart';
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
              //home: const HomePage(),
               home: const LoginPage());
              //home: const RecipePage());
        });
  }
}
