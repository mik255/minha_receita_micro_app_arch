import 'package:micro_app_common/micro_app_common.dart';

import '../pages/home_page.dart';

final homeRoutes = <CommonNavigator>[
  CommonNavigator(
    routePrefix: '/home',
    routeName: '/main',
    page: (args, queryParameters) => const HomePage(),
  ),
];
