import '../../../../common/navigator/navigator.dart';
import '../pages/login_page.dart';

final accountRoutes = <CommonNavigator>[
  CommonNavigator(
    routePrefix: '',
    routeName: '/',
    page: (args, queryParameters) => const LoginPage(),
  ),
  // CommonNavigator(
  //   routePrefix: '/account',
  //   routeName: '/register',
  //   page: (args, queryParameters) => const RegisterPage(),
  // ),
];
