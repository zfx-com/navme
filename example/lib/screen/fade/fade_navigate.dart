import 'package:flutter/material.dart';

import 'package:navme/navme.dart';

import '../../navigation/index.dart';
import 'index.dart';

class FadeNavigate {
  static String path = 'fade';
  static RouteConfig routeConfig = RouteConfig(
    state: (Uri uri) => RouteState(uri: path.toUri()),
    isThisPage: (RouteState state) {
      if (state?.firstPath == path) {
        return true;
      }
      return false;
    },
    settings: (RouteState state) {
      return null;
    },
    page: ({RouteState state}) {
      return FadePage(key: const ValueKey('FadePage'), child: FadeScreen());
    },
  );
}
