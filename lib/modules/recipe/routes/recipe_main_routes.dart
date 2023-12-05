import '../../../../../core/route/route_contract.dart';
import '../ingredients/presentation/pages/ingredients_page.dart';
import '../main/pages/recipe_main_page.dart';

final recipeMainRoutes = <RoutesCore>[
  RoutesCore(
    routePrefix: '/recipe',
    routeName: '/main',
    page: (args, queryParameters) => const RecipeMainPage(),
  ),
  RoutesCore(
    routePrefix: '/recipe',
    routeName: '/ingredients',
    page: (args, queryParameters) => const IgredientsPage(),
  ),
];
