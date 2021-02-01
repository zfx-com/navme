import 'package:flutter/material.dart';
import 'package:navme/navme.dart';

import 'index.dart';

class BooksListNavigate {
  // base path
  static String path = 'book';

  // config for configurate Router
  static RouteConfig routeConfig = RouteConfig(
    state: RouteState(uri: path.toUri()),
    // condition for using this page
    isThisPage: (RouteState state) {
      if ((state?.firstPath == path ||
              state?.uri?.pathSegments?.isEmpty == true) &&
          !state.hasParams) {
        return true;
      }
      return false;
    },
    // settigs from url
    settings: (RouteState state) {
      return null;
    },
    // get Page for Router
    page: ({RouteState state}) {
      return MaterialPage(
          key: const ValueKey('BooksListPage'),
          child: BooksListScreen.all(),
          name: 'BooksListScreen');
    },
  );
}
