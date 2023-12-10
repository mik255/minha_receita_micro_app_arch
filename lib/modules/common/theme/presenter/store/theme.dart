import 'package:flutter/cupertino.dart';
import '../../../../../design_system/themes.dart';

class AppThemeStore extends ChangeNotifier {
  bool isDarkTheme = false;

  void switchTheme() {
    isDarkTheme = !isDarkTheme;
    DSMaterialThemeSingleton.instance.setTheme(isDark: isDarkTheme);
    notifyListeners();
  }

  AnimationController getAnimController(TickerProvider ticker) {
    var animationDuration = const Duration(milliseconds: 1000);
    var animation = AnimationController(
      vsync: ticker,
      duration: animationDuration,
    );
    double startOfAnimation = isDarkTheme ? 1 : 0;
    animation.value = startOfAnimation;
    if (!isDarkTheme) {
      return animation..forward();
    }

    return animation..reverse();
  }
}
