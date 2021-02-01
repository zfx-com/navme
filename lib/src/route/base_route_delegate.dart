import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'index.dart';

abstract class BaseRouterDelegate extends RouterDelegate<RouteState> with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteState> {
  BaseRouterDelegate({@required this.initConfig, @required this.configs})
      : navigatorKey = GlobalKey<NavigatorState>(),
        currentState = initConfig.state;

  final List<RouteConfig> configs;
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final RouteConfig initConfig;

  List<RouteState> previousState = [];
  bool init = false;

  RouteState currentState;
  List<Page<dynamic>> pages;

  /// use careful
  RouteState get backState {
    var value = initConfig.state;
    if (pages.isNotEmpty) {
      pages.removeLast();
    }
    if (previousState.isNotEmpty && pages.length == previousState.length) {
      value = previousState.last;
      previousState.removeLast();
    }
    return value;
  }

  void updatePage(RouteState newState, {bool notif = true}) {
    for (final item in configs) {
      final isThisPage = item.isThisPage(newState);
      if (isThisPage) {
        pages.add(item.page(state: newState));
        if (notif == true) {
          notifyListeners();
        }
        return;
      }
    }
    if (notif == true) {
      notifyListeners();
    }
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> setNewRoutePath(RouteState newState) async {
    assert(newState != null, 'newState must be not null');
    // fix dublicate start page
    if (init == false && initConfig.isThisPage(newState)) {
      init = true;
      return;
    }

    // update state
    currentState = newState;
    updatePage(currentState, notif: false);
  }

  List<Page<dynamic>> buildPage() {
    if (pages == null || pages.isEmpty) {
      pages = [];
      pages.add(initConfig.page(state: initConfig.state));
      return pages;
    }

    // check key of pages
    if (!kReleaseMode) {
      final keys = pages.map((e) => e.key?.toString()).toList();
      final distinct = keys.toSet();
      if (distinct.length != keys.length) {
        distinct.forEach(keys.remove);
        assert(false, 'dublicate keys page: ${keys.join(',')}');
      }
    }

    // always return new object
    return [...pages];
  }

  void push(Uri uri) {
    previousState.add(currentState);
    currentState = RouteState(uri: uri);
    updatePage(currentState);
  }

  void pop() {
    currentState = backState;
    notifyListeners();
  }

  void replace(Uri uri) {
    pages.clear();
    previousState.clear();
    currentState = RouteState(uri: uri);
    updatePage(currentState);
  }

  void refresh() {
    notifyListeners();
  }
}
