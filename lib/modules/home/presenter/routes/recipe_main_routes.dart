import '../../../../design_system/navigator/core/route/route_contract.dart';
import '../pages/home_page.dart';

final recipeMainRoutes = <DSNavigatorRoute>[
  DSNavigatorRoute(
    routePrefix: '/home',
    routeName: '/main',
    page: (args, queryParameters) => const HomePage(),
  ),
];
