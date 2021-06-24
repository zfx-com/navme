import 'package:flutter/material.dart';

import 'package:navme/navme.dart';

import '../screen/book_details/index.dart';
import '../screen/books_list/index.dart';
import '../screen/fade/index.dart';
import '../screen/home/index.dart';
import '../screen/nested/index.dart';
import '../screen/unknown_screen.dart';

class NavmeRouterDelegate extends BaseRouterDelegate {
  NavmeRouterDelegate(
      {required RouteConfig initialRoute,
      required List<RouteConfig> routes,
      required RouteConfig onUnknownRoute,
      String? nestedPrefixPath,
      String? debugLabel})
      : super(
          initialRoute: initialRoute,
          routes: routes,
          onUnknownRoute: onUnknownRoute,
          nestedPrefixPath: nestedPrefixPath,
          debugLabel: debugLabel,
        );

  factory NavmeRouterDelegate.main() {
    return NavmeRouterDelegate(
      initialRoute: HomeNavigate.routeConfig,
      routes: [
        HomeNavigate.routeConfig,
        BookDetailsNavigate.routeConfig,
        BooksListNavigate.routeConfig,
        FadeNavigate.routeConfig,
        NestedNavigate.routeConfig,
      ],
      onUnknownRoute: UnknownNavigate.routeConfig,
      debugLabel: 'main',
    );
  }

  factory NavmeRouterDelegate.nested() {
    return NavmeRouterDelegate(
      initialRoute: HomeNavigate.nestedRouteConfig,
      routes: [
        HomeNavigate.nestedRouteConfig,
        BookDetailsNavigate.routeConfig,
        BooksListNavigate.routeConfig,
        FadeNavigate.routeConfig,
      ],
      onUnknownRoute: UnknownNavigate.routeConfig,
      nestedPrefixPath: NestedNavigate.path,
      debugLabel: 'nested',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      observers: [HeroController()], // THIS IS THE IMPORTANT LINE for Hero
      pages: buildPage(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        pop();
        return true;
      },
    );
  }
}
