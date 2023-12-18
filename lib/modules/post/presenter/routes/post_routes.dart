import '../../../common/navigator/navigator.dart';
import '../page/post_recipe.dart';

final postRoutes = <CommonNavigator>[
  CommonNavigator(
    routePrefix: '/post',
    routeName: '/recipe',
    page: (args, queryParameters) => const PostRecipePage(),
  ),
];
