import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'index.dart';

class RouteConfig {
  RouteConfig({
    @required this.page,
    @required this.state,
    @required this.isThisPage,
    @required this.settings,
  });

  final RouteState state;
  final bool Function(RouteState state) isThisPage;
  final Map<String, String> Function(RouteState state) settings;
  final Page Function({RouteState state}) page;

  RouteConfig copyWith(
      {RouteState state,
      bool Function(RouteState state) isThisPage,
      Map<String, String> Function(RouteState state) settings,
      Page Function({RouteState state}) page}) {
    return RouteConfig(
      state: state ?? this.state,
      isThisPage: isThisPage ?? this.isThisPage,
      settings: settings ?? this.settings,
      page: page ?? this.page,
    );
  }
}
