import '../../../../../core/route/route_contract.dart';
import '../../ingredients/presentation/pages/ingredients_page.dart';

final ingredientsRoutes = <RoutesCore>[
  RoutesCore(
    routePrefix: '/recipe',
    routeName: '/ingredients',
    page: (args, queryParameters) => const IgredientsPage(),
  ),
];
