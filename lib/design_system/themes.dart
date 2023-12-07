//singleton material theme
import 'package:flutter/material.dart';

class DSMaterialThemeSingleton {
  static DSMaterialThemeSingleton? _instance;

  static DSMaterialThemeSingleton get instance {
    _instance ??= DSMaterialThemeSingleton._init();
    return _instance!;
  }

  DSMaterialThemeSingleton._init();

  ThemeData get lightTheme => ThemeData(
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          onSurface: const Color(0xFF000000),
          seedColor: Colors.red,
          tertiary: Colors.white,
          primary: const Color(0xFFFF9811),
          secondary: const Color(0xFF3D3D4D),
          onSecondary: const Color(0x94000000),
          tertiaryContainer: const Color(0x8EB9C2D5),
          secondaryContainer: const Color(0xFF151528),
          background: const Color(0xFFFFFFFF),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF3D3D4D),
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF3D3D4D),
          ),
        ),
        useMaterial3: true,
      );

  ThemeData get darkThemeData => ThemeData(
        splashColor: Colors.transparent,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          onSurface: const Color(0xFFFFFFFF),
          seedColor: Colors.red,
          tertiary: Colors.white,
          primary: const Color(0xFFFF9811),
          secondary: Colors.white,
          tertiaryContainer: const Color(0xFFFF9811),
          background: const Color(0xFF191622),
          secondaryContainer: const Color(0xFF151528),
        ),
      );

  ThemeData get customTheme => ThemeData(
        splashColor: Colors.transparent,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
            tertiary: Colors.white,
            primary: const Color(0xFF411E0F),
            secondary: const Color(0xFFE7939D),
            tertiaryContainer: const Color(0xFF460F0F),
            background: const Color(0xFF773038)),
      );
  ValueNotifier<ThemeData> currentTheme = ValueNotifier(ThemeData());

  void setTheme({required bool isDark}) =>
      currentTheme.value = isDark ? darkThemeData : lightTheme;
}
