import '../../../../../core/route/route_contract.dart';
import '../pages/home_page.dart';

final recipeMainRoutes = <RoutesCore>[
  RoutesCore(
    routePrefix: '/recipe',
    routeName: '/main',
    page: (args, queryParameters) => const RecipeMainPage(),
  ),
];
