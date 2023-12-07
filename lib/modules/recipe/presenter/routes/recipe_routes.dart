import '../../../../../core/route/route_contract.dart';
import '../pages/recipe_page.dart';

final recipeRoutes = <RoutesCore>[
  RoutesCore(
    routePrefix: '/recipe',
    routeName: '/ingredients',
    page: (args, queryParameters) => const RecipePage(),
  ),
];
