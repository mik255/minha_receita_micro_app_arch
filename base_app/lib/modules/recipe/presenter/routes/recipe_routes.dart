import 'package:micro_app_common/micro_app_common.dart';
import 'package:minha_receita/modules/recipe/presenter/pages/recipe_page.dart';

final recipeRoutes = <CommonNavigator>[
  CommonNavigator(
    routePrefix: '/recipe',
    routeName: '/main',
    page: (args, queryParameters) => const RecipePage(),
  ),
];
