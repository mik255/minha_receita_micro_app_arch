import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';
import 'modules_injections.dart';


void main() {
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
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
    DSMaterialThemeSingleton.instance.setTheme(isDark: false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (BuildContext context, Widget? child) {
        return Material(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: child ?? Container(),
          ),
        );
      },
      theme: DSMaterialThemeSingleton.instance.currentTheme.value,
      debugShowCheckedModeBanner: false,
      title: 'Minha receita',
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}


