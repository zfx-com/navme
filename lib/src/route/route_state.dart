import 'package:flutter/widgets.dart';

import '../helpers/index.dart';

@immutable

/// Router state for navme router delegate basede on Uri
class RouteState {
  /// create state from Uri, state based on web navigation model
  RouteState({required this.uri, this.uriState, this.innerState});

  /// current Uri
  final Uri? uri;

  /// an uri app state so that the app can have different states
  /// even in the same uri, must be serializable
  final Object? uriState;

  /// an inner app state so that web browser cannot restore the state
  final Object? innerState;

  /// uri => string
  String get location {
    return uri.toString();
  }

  /// helper for condition with first path
  String? get firstPath => uri?.pathSegments.firstOrDefault;

  /// has queryParameters?
  bool get hasParams =>
      // (uri?.pathSegments != null && !uri.pathSegments.empty) ||
      uri!.queryParameters.isNotEmpty;

  @override
  String toString() => 'RouteState(uri: ${uri?.toString()} state: $uriState)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is RouteState &&
        other.uri == uri &&
        other.uriState == uriState;
  }

  /// safe gettter for queryParameters
  String? getQueryValue(String key) {
    String? result;
    if (uri!.queryParameters.containsKey(key)) {
      result = uri!.queryParameters[key];
      return result;
    }
    return null;
  }

  @override
  int get hashCode => uri.hashCode;

  /// remove nestedPrefixPath from uri
  RouteState diff(String? nestedPrefixPath) {
    if (nestedPrefixPath == null ||
        nestedPrefixPath == '' ||
        nestedPrefixPath == '/') {
      return this;
    }
    final uriStr = uri?.toString() ?? '';
    if (uriStr.startsWith(nestedPrefixPath)) {
      return RouteState(uri: uriStr.substring(nestedPrefixPath.length).toUri());
    }
    return this;
  }
}
