import 'package:flutter/material.dart';

import '../helpers/index.dart';
import 'index.dart';

/// Convert [Uri] to [String] and [String] to [Uri] for [RouteState]
class StateRouteInformationParser extends RouteInformationParser<RouteState> {
  @override
  Future<RouteState> parseRouteInformation(
      RouteInformation routeInformation) async {
    l.log('parseRouteInformation =  ${routeInformation.location}',
        name: 'StateRouteInformationParser');
    return RouteState(
      uri: routeInformation.location?.toUri(),
      uriState: routeInformation.state,
    );
  }

  @override
  RouteInformation restoreRouteInformation(RouteState configuration) {
    l.log('restoreRouteInformation =  $configuration',
        name: 'StateRouteInformationParser');
    return RouteInformation(
      location: configuration.location,
      state: configuration.uriState,
    );
  }
}
