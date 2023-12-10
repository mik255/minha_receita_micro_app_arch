import '../../../common/navigator/navigator.dart';
import '../pages/home_page.dart';

final recipeMainRoutes = <CommonNavigator>[
  CommonNavigator(
    routePrefix: '/home',
    routeName: '/main',
    page: (args, queryParameters) => const HomePage(),
  ),
];
