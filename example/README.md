## Example use

Example config for page:

```dart
  // base path
  static String path = 'book';

  // config for configurate Router
  static RouteConfig routeConfig = RouteConfig(
    state: (Uri uri) => RouteState(uri: path.toUri()),
    // condition for using this page
    isThisPage: (RouteState state) {
      if (state?.firstPath == path) {
        return true;
      }
      return false;
    },
    // settigs from url
    settings: (RouteState state) {
      return null;
    },
    // get Page for Router
    page: ({RouteState state}) {
      return MaterialPage(
          key: const ValueKey('BooksListPage'),
          child: BooksListScreen.all(),
          name: 'BooksListScreen');
    },
  );
```

Implementation BaseRouterDelegate for your configuration

```dart
class NavmeRouterDelegate extends BaseRouterDelegate {
  NavmeRouterDelegate()
      : super(
          // base route
          initialRoute: BooksListNavigate.routeConfig,
          routes: [
            // pages
            BookDetailsNavigate.routeConfig,
            BooksListNavigate.routeConfig,
            FadeNavigate.routeConfig,
            NestedNavigate.routeConfig,
          ],
          onUnknownRoute: UnknownNavigate.routeConfig,
        );

  @override
  RouteState get currentConfiguration {
    return currentState;
  }

  // helper
  static NavmeRouterDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    if (delegate is NavmeRouterDelegate) {
      return delegate;
    }
    assert(() {
      throw FlutterError('Router operation requested with a context that does not include a NavmeRouterDelegate.\n');
    }(), 'Router operation requested with a context that does not include a NavmeRouterDelegate.\n');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      observers: [HeroController()], // THIS IS THE IMPORTANT LINE for Hero
      pages: buildPage(), // your stack pages
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        pop();
        return true;
      },
    );
  }
}
```

use Router:

```dart
 final NavmeRouterDelegate _routerDelegate = NavmeRouterDelegate();
  final StateRouteInformationParser _stateRouteInformation =
      StateRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _routerDelegate,
      routeInformationParser: _stateRouteInformation,
    );
  }
```

Navigate to the new detail book page

```dart
  NavmeRouterDelegate.of(context)
                          ?.push(BookDetailsNavigate.getUri(book));
```