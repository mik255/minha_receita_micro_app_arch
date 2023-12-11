import 'package:minha_receita/modules/account/presenter/pages/login_page.dart';
import 'package:minha_receita/modules/account/presenter/pages/register_page.dart';

import '../../../common/navigator/navigator.dart';

final accountRoutes = <CommonNavigator>[
  CommonNavigator(
    routePrefix: '/account',
    routeName: '/login',
    page: (args, queryParameters) => const LoginPage(),
  ),
  CommonNavigator(
    routePrefix: '/account',
    routeName: '/register',
    page: (args, queryParameters) => const RegisterPage(),
  ),
];
