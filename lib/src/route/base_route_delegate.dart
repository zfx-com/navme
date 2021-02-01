import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'index.dart';

/// A delegate that is used by the [Router] widget to build and configure a
/// navigating widget.
///
/// This delegate is the core piece of the [Router] widget. It responds to
/// push route and pop route intents from the engine and notifies the [Router]
/// to rebuild. It also acts as a builder for the [Router] widget and builds a
/// navigating widget, typically a [Navigator], when the [Router] widget
/// builds.
///
/// When the engine pushes a new route, the route information is parsed by the
/// [RouteInformationParser] to produce a configuration of type [RouteState].
abstract class BaseRouterDelegate extends RouterDelegate<RouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteState> {
  /// initConfig - required initial [RouteConfig] for create Router initial page
  /// configs - List of [RouteConfig] all pages in your Navigator
  BaseRouterDelegate({@required this.initConfig, @required this.configs})
      : navigatorKey = GlobalKey<NavigatorState>(),
        currentState = initConfig.state;

  /// List of [RouteConfig] all pages in your Navigator
  final List<RouteConfig> configs;
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  /// required initial [RouteConfig] for create Router initial page
  final RouteConfig initConfig;

  /// history states
  List<RouteState> previousState = [];

  /// current [RouteState] of [Router]
  RouteState currentState;

  /// Stack pages in this moment
  List<Page<dynamic>> pages;

  bool _init = false;

  /// use careful, update variable when will get
  /// Update pages and state in back
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

  /// add new page in stack by new [RouteState]
  /// notif - use notifyListeners
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
  Future<void> setNewRoutePath(RouteState configuration) async {
    assert(configuration != null, 'configuration must be not null');
    // fix dublicate start page
    if (_init == false && initConfig.isThisPage(configuration)) {
      _init = true;
      return;
    }

    // update state
    currentState = configuration;
    updatePage(currentState, notif: false);
  }

  /// return List [Page] for render stack pages in Navigator 2.0
  /// always return a new instance of List to build new render
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

  /// Add new page in stack pages
  void push(Uri uri) {
    previousState.add(currentState);
    currentState = RouteState(uri: uri);
    updatePage(currentState);
  }

  /// remove last page in stack pages
  void pop() {
    currentState = backState;
    notifyListeners();
  }

  /// remove all current stack pages and add one new page in stack
  void replace(Uri uri) {
    pages.clear();
    previousState.clear();
    currentState = RouteState(uri: uri);
    updatePage(currentState);
  }

  /// use notifyListeners
  void refresh() {
    notifyListeners();
  }
}
