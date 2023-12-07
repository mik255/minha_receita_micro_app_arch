import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:minha_receita/modules/ingredients/routes/ingredients_routes.dart';
import 'core/config/config.dart';
import 'core/di/injections.dart';
import 'core/route/route_contract.dart';
import 'design_system/themes.dart';
import 'modules/home/main/pages/recipe_main_page.dart';
import 'modules/home/routes/recipe_main_routes.dart';

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
    RoutesCore.routes.addAll([
      ...recipeMainRoutes,
      ...ingredientsRoutes
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
            navigatorKey: navigateKey,
            onGenerateRoute: RoutesCore.generateRoute,
            title: 'Flutter Demo',
            theme: DSMaterialThemeSingleton.instance.currentTheme.value,
            home: const RecipeMainPage(),
          );
        });
  }
}

