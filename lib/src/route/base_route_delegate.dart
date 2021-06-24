import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../helpers/index.dart';
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
    required this.initialRoute,
    required this.routes,
    required this.onUnknownRoute,
    this.nestedPrefixPath,
    String? debugLabel,
  })  : _debugLabel = debugLabel,
        navigatorKey = GlobalKey<NavigatorState>(),
        currentState = initialRoute.state(null);

  /// List of [RouteConfig] all pages in your Navigator
  final List<RouteConfig> routes;
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  /// required initial [RouteConfig] for create Router initial page
  final RouteConfig initialRoute;

  /// prefix path for Nested Navigator
  final String? nestedPrefixPath;

  final String? _debugLabel;

  /// name for debug
  String get debugLabel => _debugLabel ?? 'BaseRouterDelegate';

  /// required [RouteConfig] for create Router Unknown page
  final RouteConfig onUnknownRoute;

  @override
  RouteState get currentConfiguration {
    return currentState;
  }

  /// history states
  List<RouteState> previousState = [];

  /// current [RouteState] of [Router]
  RouteState currentState;

  /// Stack pages in this moment
  List<Page<dynamic>>? pages;

  bool _init = false;

  /// use careful, update variable when will get
  /// Update pages and state in back
  RouteState backState({bool removeLast = false}) {
    l.log('backState: removeLast =  $removeLast', name: debugLabel);
    var value = initialRoute.state(null);
    if (pages!.isNotEmpty) {
      if (pages!.length > 1 || removeLast) {
        pages!.removeLast();
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

  /// get instance routerDelegate from context
  static BaseRouterDelegate? of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    if (delegate is BaseRouterDelegate) {
      return delegate;
    }
    assert(() {
      throw FlutterError(
          // ignore: lines_longer_than_80_chars
          'Router operation requested with a context that does not include a BaseRouterDelegate.\n');
    }(),
        // ignore: lines_longer_than_80_chars
        'Router operation requested with a context that does not include a BaseRouterDelegate.\n');
    return null;
  }

  /// add new page in stack by new [RouteState]
  /// notif - use notifyListeners
  /// addOne - return when added one page from routes config
  /// fromLast - foreach config from last route
  void updatePage(RouteState newState,
      {bool notif = true, bool addOne = false, bool fromLast = false}) {
    l.log(
        // ignore: lines_longer_than_80_chars
        'updatePage: newState= $newState, notif = $notif , addOne = $addOne , fromLast = $fromLast',
        name: debugLabel);
    l.log('pages $pages', name: debugLabel);
    var findedPage = false;
    final configs = [...routes, initialRoute];
    final routesList = fromLast ? configs : configs.reversed.toList();
    for (final item in routesList) {
      final newStateWithoutPrefix = newState.diff(nestedPrefixPath);
      l.log('newStateWithoutPrefix $newStateWithoutPrefix', name: debugLabel);
      final isThisPage = item.isThisPage(newStateWithoutPrefix);
      if (isThisPage) {
        l.log('add page ${item.state(newState.uri)}', name: debugLabel);
        previousState.add(RouteState(
          uri: item.state(newState.uri).uri,
          uriState: newState.uriState,
          innerState: newState.innerState,
        ));
        currentState = RouteState(
          uri: newState.uri,
          uriState: newState.uriState,
          innerState: newState.innerState,
        );
        pages!.add(item.page(state: newState));
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
      currentState = RouteState(uri: newState.uri, uriState: newState.uriState);
      pages!.add(onUnknownRoute.page());
    }
    if (notif == true) {
      notifyListeners();
    }
  }

  @override
  Future<void> setNewRoutePath(RouteState configuration) async {
    l.log('setNewRoutePath = $configuration', name: debugLabel);
    // fix dublicate start page
    if (_init == false && initialRoute.isThisPage(configuration)) {
      _init = true;
      previousState.add(RouteState(
          uri: initialRoute.state(configuration.uri).uri,
          uriState: configuration.uriState));
      return;
    }
    pages?.clear();
    previousState.clear();

    updatePage(configuration,
        addOne: configuration.uri == initialRoute.state(null).uri);
  }

  /// return List [Page] for render stack pages in Navigator 2.0
  /// always return a new instance of List to build new render
  List<Page<dynamic>> buildPage() {
    l.log('buildPage', name: debugLabel);
    if (pages == null || pages!.isEmpty) {
      l.log('buildPage: init', name: debugLabel);
      pages = [];
      pages!.add(initialRoute.page(state: initialRoute.state(null)));
      return pages!;
    }

    // check key of pages
    if (!kReleaseMode) {
      final keys = pages!.map((e) => e.key?.toString()).toList();
      final distinct = keys.toSet();
      if (distinct.length != keys.length) {
        distinct.forEach(keys.remove);
        l.log('pages = $pages', name: debugLabel);
        assert(false, 'dublicate keys page: ${keys.join(',')}');
      }
    }

    l.log('return buildPage: pages = $pages', name: debugLabel);
    // always return new object
    return [...pages!];
  }

  /// Add new page in stack pages with nestedprefix
  void pushNested(Uri uri, {Object? uriState, Object? innerState}) {
    updatePage(
        RouteState(
          uri: '${nestedPrefixPath ?? ''}/$uri'.toUri(),
          uriState: uriState,
          innerState: innerState,
        ),
        addOne: true,
        fromLast: true);
  }

  /// Add new page in stack pages
  void push(Uri uri, {Object? uriState, Object? innerState}) {
    updatePage(RouteState(uri: uri, uriState: uriState, innerState: innerState),
        addOne: true, fromLast: true);
  }

  /// remove last page in stack pages
  /// removeLast-if stack have one page remove this page and build initial page
  void pop({bool removeLast = false}) {
    currentState = backState(removeLast: removeLast);
    notifyListeners();
  }

  /// remove all current stack pages and add one new page in stack
  void replace(Uri uri, {Object? uriState, Object? innerState}) {
    pages?.clear();
    previousState.clear();
    currentState =
        RouteState(uri: uri, uriState: uriState, innerState: innerState);
    updatePage(currentState, addOne: true, fromLast: true);
  }

  /// use notifyListeners
  void refresh() {
    notifyListeners();
  }
}
