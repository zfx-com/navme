import 'package:flutter/material.dart';
import 'package:navme/navme.dart';
import 'index.dart';

class NestedNavigate {
  static String path = 'nested';
  static RouteConfig routeConfig = RouteConfig(
    state: RouteState(uri: path.toUri()),
    isThisPage: (RouteState state) {
      if ((state?.firstPath == path || state?.uri?.pathSegments?.isEmpty == true) && !state.hasParams) {
        return true;
      }
      return false;
    },
    settings: (RouteState state) {
      return null;
    },
    page: ({RouteState state}) {
      return MaterialPage(key: const ValueKey('NestedPage'), child: NestedScreen(), name: 'NestedScreen');
    },
  );
}
