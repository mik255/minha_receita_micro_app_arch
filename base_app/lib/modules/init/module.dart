import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_receita/modules/init/presenter/splash.dart';

import '../register_recipe/presenter/pages/register_recipe_page.dart';

class InitModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute(
    //   transition: TransitionType.leftToRight,
    //   duration: const Duration(milliseconds: 500),
    //   Modular.initialRoute,
    //   child: (_, __) => const SplashScreen(),
    // ),
    ChildRoute(
      transition: TransitionType.leftToRight,
      duration: const Duration(milliseconds: 500),
      Modular.initialRoute,
      child: (_, __) => RegisterRecipe(),
    ),
  ];
}
