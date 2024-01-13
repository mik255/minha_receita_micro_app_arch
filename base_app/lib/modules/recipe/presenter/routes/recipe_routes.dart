import 'package:minha_receita/modules/recipe/presenter/pages/recipe_page.dart';

import '../../../../common/navigator/navigator.dart';
import '../pages/register/recipe_register_page.dart';

final recipeRoutes = <CommonNavigator>[
  CommonNavigator(
    routePrefix: '/recipe',
    routeName: '/main',
    page: (args, queryParameters) => const RecipePage(),
  ),
  CommonNavigator(
    routePrefix: '/recipe',
    routeName: '/register',
    page: (args, queryParameters) => const RegisterRecipePage(),
  ),
];
