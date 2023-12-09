//make a snack bar component

import 'package:flutter/material.dart';

class DSSnackBar {
  const DSSnackBar({
    Key? key,
    required this.message,
    this.action,
    this.duration = const Duration(seconds: 3),
    this.backgroundColor,
    this.textColor,
  });

  final String message;
  final String? action;
  final Duration duration;
  final Color? backgroundColor;
  final Color? textColor;

  SnackBar get build => SnackBar(
        backgroundColor: backgroundColor,
        duration: duration,
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
          ),
        ),
        action: action != null
            ? SnackBarAction(
                label: action!,
                textColor: textColor,
                onPressed: () {},
              )
            : null,
      );
}
