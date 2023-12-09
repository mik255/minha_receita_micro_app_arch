import '../../../../design_system/navigator/core/route/route_contract.dart';
import '../pages/recipe_page.dart';

final recipeRoutes = <DSNavigatorRoute>[
  DSNavigatorRoute(
    routePrefix: '/recipe',
    routeName: '/ingredients',
    page: (args, queryParameters) => const RecipePage(),
  ),
];
