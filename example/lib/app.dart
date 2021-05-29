import 'package:flutter/material.dart';
import 'package:navme/navme.dart';

import 'navigation/index.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final NavmeRouterDelegate _routerDelegate = NavmeRouterDelegate.main();
  final StateRouteInformationParser _stateRouteInformation =
      StateRouteInformationParser();

  PlatformRouteInformationProvider _routeInformationProvider;
  PlatformRouteInformationProvider get routeInformationProvider =>
      _routeInformationProvider ??= PlatformRouteInformationProvider(
          initialRouteInformation: const RouteInformation(location: '/'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _routerDelegate,
      routeInformationParser: _stateRouteInformation,
      routeInformationProvider: routeInformationProvider,
    );
  }
}
