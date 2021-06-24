import 'package:flutter/material.dart';
import 'package:navme/navme.dart';
import 'package:navme/helpers.dart';
import '../nested/index.dart';

import 'index.dart';

class HomeNavigate {
  // base path
  static String path = '/';

  // config for configurate Router
  static RouteConfig routeConfig = RouteConfig(
    state: (Uri? uri) => RouteState(uri: path.toUri()),
    // condition for using this page
    isThisPage: (RouteState state) {
      if (state.location == path) {
        return true;
      }
      return false;
    },
    // settigs from url
    settings: (RouteState state) {
      return null;
    },
    // get Page for Router
    page: ({RouteState? state}) {
      return MaterialPage(
          key: const ValueKey('HomePage'),
          child: HomeScreen(),
          name: 'HomeScreen');
    },
  );

  static RouteConfig nestedRouteConfig = RouteConfig(
    state: (Uri? uri) => RouteState(uri: NestedNavigate.path.toUri()),
    // condition for using this page
    isThisPage: (RouteState state) {
      if (state.location == path || state.location == '') {
        return true;
      }
      return false;
    },
    // settigs from url
    settings: (RouteState state) {
      return null;
    },
    // get Page for Router
    page: ({RouteState? state}) {
      return MaterialPage(
        key: UniqueKey(),
        child: HomeScreen(),
        name: 'HomeScreen',
      );
    },
  );
}
