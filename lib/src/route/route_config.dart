import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'index.dart';

/// Describes when, how and what will be used in Router
@immutable
class RouteConfig {
  ///
  RouteConfig({
    required this.page,
    required this.state,
    required this.isThisPage,
    required this.settings,
  });

  /// clean uri to page [RouteState]
  /// using for calculate previos state when set any uri from browser
  final RouteState Function(Uri? uri) state;

  /// condition for use this page in navigator action
  final bool Function(RouteState state) isThisPage;

  /// get setting from state(url)
  final Map<String, String?>? Function(RouteState state) settings;

  /// function for create a page from settings, widget,
  /// and set animation transaction
  final Page Function({RouteState? state}) page;

  /// update state
  RouteConfig copyWith(
      {RouteState Function(Uri? uri)? state,
      bool Function(RouteState state)? isThisPage,
      Map<String, String> Function(RouteState state)? settings,
      Page Function({RouteState? state})? page}) {
    return RouteConfig(
      state: state ?? this.state,
      isThisPage: isThisPage ?? this.isThisPage,
      settings: settings ?? this.settings,
      page: page ?? this.page,
    );
  }
}
