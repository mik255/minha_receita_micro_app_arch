import 'package:minha_receita/modules/recipe/presenter/pages/recipe_page.dart';

import '../../../common/navigator/navigator.dart';

final recipeRoutes = <CommonNavigator>[
  CommonNavigator(
    routePrefix: '/recipe',
    routeName: '/main',
    page: (args, queryParameters) => const RecipePage(),
  ),
];
