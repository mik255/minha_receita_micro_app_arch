import '../../../common/navigator/navigator.dart';
import '../pages/recipe_page.dart';

final recipeRoutes = <CommonNavigator>[
  CommonNavigator(
    routePrefix: '/recipe',
    routeName: '/ingredients',
    page: (args, queryParameters) => const RecipePage(),
  ),
];
