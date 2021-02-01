import 'package:flutter/material.dart';

import 'package:navme/navme.dart';

import '../screen/book_details/index.dart';
import '../screen/books_list/index.dart';
import '../screen/fade/index.dart';
import '../screen/nested/index.dart';
import '../screen/unknown_screen.dart';

class NavmeRouterDelegate extends BaseRouterDelegate {
  NavmeRouterDelegate()
      : super(
          initConfig: BooksListNavigate.routeConfig,
          configs: [
            BookDetailsNavigate.routeConfig,
            BooksListNavigate.routeConfig,
            FadeNavigate.routeConfig,
            NestedNavigate.routeConfig,
            UnknownNavigate.routeConfig,
          ],
        );

  @override
  RouteState get currentConfiguration {
    return currentState;
  }

  static NavmeRouterDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    if (delegate is NavmeRouterDelegate) {
      return delegate;
    }
    assert(() {
      throw FlutterError('Router operation requested with a context that does not include a NavmeRouterDelegate.\n');
    }(), 'Router operation requested with a context that does not include a NavmeRouterDelegate.\n');
    return null;
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
