import 'package:flutter/widgets.dart';

import 'index.dart';

@immutable
class RouteState {
  // final String path;

  RouteState({@required this.uri});

  final Uri uri;

  String get location {
    return uri.toString();
  }

  String get firstPath => uri?.pathSegments?.firstOrDefault;
  bool get hasParams =>
      // (uri?.pathSegments != null && !uri.pathSegments.empty) ||
      uri.queryParameters != null && uri.queryParameters.isNotEmpty;

  @override
  String toString() => uri?.toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is RouteState && other.uri == uri;
  }

  String getQueryValue(String key) {
    if (uri.queryParameters == null) {
      return null;
    }
    String result;
    if (uri.queryParameters.containsKey(key)) {
      result = uri.queryParameters[key];
      return result;
    }
    return null;
  }

  @override
  int get hashCode => uri.hashCode;
}
