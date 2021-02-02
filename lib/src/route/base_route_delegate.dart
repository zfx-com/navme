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
  /// initialRoute-required initial [RouteConfig] for create Router initial page
  /// routes - List of [RouteConfig] all pages in your Navigator
  /// onUnknownRoute-required [RouteConfig] for create Router Unknown page
  BaseRouterDelegate({
    @required this.initialRoute,
    @required this.routes,
    @required this.onUnknownRoute,
  })  : navigatorKey = GlobalKey<NavigatorState>(),
        currentState = initialRoute.state(null);

  /// List of [RouteConfig] all pages in your Navigator
  final List<RouteConfig> routes;
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  /// required initial [RouteConfig] for create Router initial page
  final RouteConfig initialRoute;

  /// required [RouteConfig] for create Router Unknown page

  final RouteConfig onUnknownRoute;

  /// history states
  List<RouteState> previousState = [];

  /// current [RouteState] of [Router]
  RouteState currentState;

  /// Stack pages in this moment
  List<Page<dynamic>> pages;

  bool _init = false;

  /// use careful, update variable when will get
  /// Update pages and state in back
  RouteState backState({bool removeLast = false}) {
    var value = initialRoute.state(null);
    if (pages.isNotEmpty) {
      if (pages.length > 1 || removeLast) {
        pages.removeLast();
      }
    }
    if (previousState.length > 1 || removeLast) {
      previousState.removeLast();
    }
    if (previousState.isNotEmpty) {
      value = previousState.last;
    }
    return value;
  }

  /// add new page in stack by new [RouteState]
  /// notif - use notifyListeners
  /// addOne - return when added one page from routes config
  /// fromLast - foreach config from last route
  void updatePage(RouteState newState,
      {bool notif = true, bool addOne = false, bool fromLast = false}) {
    var findedPage = false;
    final configs = [initialRoute, ...routes];
    final routesList = fromLast ? configs : configs.reversed.toList();
    for (final item in routesList) {
      final isThisPage = item.isThisPage(newState);
      if (isThisPage) {
        previousState.add(item.state(newState.uri));
        currentState = RouteState(uri: newState.uri);
        pages.add(item.page(state: newState));
        findedPage = true;

        if (notif == true) {
          notifyListeners();
        }
        if (addOne == true) {
          return;
        }
      }
    }
    if (findedPage == false) {
      previousState.add(currentState);
      currentState = RouteState(uri: newState.uri);
      pages.add(onUnknownRoute.page());
    }
    if (notif == true) {
      notifyListeners();
    }
  }

  @override
  Future<void> setNewRoutePath(RouteState configuration) async {
    assert(configuration != null, 'configuration must be not null');
    // fix dublicate start page
    if (_init == false && initialRoute.isThisPage(configuration)) {
      _init = true;
      return;
    }
    pages?.clear();
    previousState.clear();

    updatePage(configuration);
  }

  /// return List [Page] for render stack pages in Navigator 2.0
  /// always return a new instance of List to build new render
  List<Page<dynamic>> buildPage() {
    if (pages == null || pages.isEmpty) {
      pages = [];
      pages.add(initialRoute.page(state: initialRoute.state(null)));
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
    updatePage(RouteState(uri: uri), addOne: true, fromLast: true);
  }

  /// remove last page in stack pages
  /// removeLast-if stack have one page remove this page and build initial page
  void pop({bool removeLast = false}) {
    currentState = backState(removeLast: removeLast);
    notifyListeners();
  }

  /// remove all current stack pages and add one new page in stack
  void replace(Uri uri) {
    pages.clear();
    previousState.clear();
    updatePage(currentState, addOne: true, fromLast: true);
  }

  /// use notifyListeners
  void refresh() {
    notifyListeners();
  }
}
