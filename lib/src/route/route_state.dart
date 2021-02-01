import 'package:flutter/widgets.dart';

import '../ext.dart';

@immutable

/// Router state for navme router delegate basede on Uri
class RouteState {
  /// create state from Uri, state based on web navigation model
  RouteState({@required this.uri});

  /// current Uri
  final Uri uri;

  /// uri => string
  String get location {
    return uri.toString();
  }

  /// helper for condition with first path
  String get firstPath => uri?.pathSegments?.firstOrDefault;

  /// has queryParameters?
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

  /// safe gettter for queryParameters
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
