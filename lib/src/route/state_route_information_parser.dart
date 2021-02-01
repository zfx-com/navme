import 'package:flutter/material.dart';

import '../ext.dart';
import 'index.dart';

/// Convert [Uri] to [String] and [String] to [Uri] for [RouteState]
class StateRouteInformationParser extends RouteInformationParser<RouteState> {
  @override
  Future<RouteState> parseRouteInformation(
      RouteInformation routeInformation) async {
    return RouteState(uri: routeInformation.location?.toUri());
  }

  @override
  RouteInformation restoreRouteInformation(RouteState configuration) {
    return RouteInformation(location: configuration.location);
  }
}
