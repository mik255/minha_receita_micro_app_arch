import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DSGetAnimations {
  Widget darkMode(Animation<double> controller) {
    return Lottie.asset(
      'packages/micro_app_design_system/lib/src/animations/assets/dark_mode.json',
      repeat: false,
      animate: true,
      controller: controller,
    );
  }
}
