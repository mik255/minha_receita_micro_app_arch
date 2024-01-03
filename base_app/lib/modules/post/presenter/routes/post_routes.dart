import 'package:micro_app_common/micro_app_common.dart';

import '../page/post_recipe.dart';

final postRoutes = <CommonNavigator>[
  CommonNavigator(
    routePrefix: '/post',
    routeName: '/recipe',
    page: (args, queryParameters) => const PostRecipePage(),
  ),
];
