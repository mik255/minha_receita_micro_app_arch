import 'package:flutter/material.dart';

class DSNavigatorRoute {
  String routeName;
  String? routePrefix;
  Widget Function(Object? args, Map? queryParameters) page;

  DSNavigatorRoute({
    required this.page,
    required this.routeName,
    this.routePrefix,
  });

  Widget Function(
      BuildContext context,
      Object? args,
      Map? queryParameters,
      ) get routePage =>
          (context, args, queryParameters) => page(args, queryParameters);

  static Set<DSNavigatorRoute> routes = {};

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var routerName = settings.name;
    var routerArgs = settings.arguments;

    var uri = Uri.parse(settings.name ?? "");
    var queryParameters = uri.queryParameters;
    var list = routes.where((element) =>
    ((element.routePrefix ?? "") + element.routeName) == routerName);

    if (list.isEmpty) return null;

    var navigateTo = list.first;

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          navigateTo.page(routerArgs, queryParameters),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}