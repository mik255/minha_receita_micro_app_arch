import 'package:flutter/material.dart';

class AppTypography {
  static const headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const headline3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const bodyText1 = TextStyle(
    fontSize: 16,
  );

  static const bodyText2 = TextStyle(
    fontSize: 14,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // Adicione outros estilos conforme necessário

  // Método para obter estilos de texto
  static TextStyle getTextStyle(TextStyle style) {
    // Você pode adicionar lógica aqui para aplicar temas, cores, etc.
    return style;
  }
}
