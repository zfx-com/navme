import 'package:flutter/material.dart';

import 'index.dart';

class StateRouteInformationParser extends RouteInformationParser<RouteState> {
  @override
  Future<RouteState> parseRouteInformation(RouteInformation routeInformation) async {
    return RouteState(uri: routeInformation.location?.toUri());
  }

  @override
  // ignore: avoid_renaming_method_parameters
  RouteInformation restoreRouteInformation(RouteState state) {
    return RouteInformation(location: state.location);
  }
}
