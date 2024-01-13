import '../../../../common/navigator/navigator.dart';
import '../pages/home_page.dart';

final homeRoutes = <CommonNavigator>[
  CommonNavigator(
    routePrefix: '/home',
    routeName: '/main',
    page: (args, queryParameters) => const HomePage(),
  ),
];
