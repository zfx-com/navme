
## Example use

Example config for page:

```dart
 class BooksListNavigate {
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
}
```

Implementation BaseRouterDelegate for your configuration

```dart
class NavmeRouterDelegate extends BaseRouterDelegate {
  NavmeRouterDelegate(
      {@required RouteConfig initialRoute,
      @required List<RouteConfig> routes,
      @required RouteConfig onUnknownRoute,
      String nestedPrefixPath,
      String debugLabel})
      : super(
          initialRoute: initialRoute,
          routes: routes,
          onUnknownRoute: onUnknownRoute,
          nestedPrefixPath: nestedPrefixPath,
          debugLabel: debugLabel,
        );

  factory NavmeRouterDelegate.main() {
    return NavmeRouterDelegate(
      initialRoute: HomeNavigate.routeConfig,
      routes: [
        HomeNavigate.routeConfig,
        BookDetailsNavigate.routeConfig,
        BooksListNavigate.routeConfig,
        FadeNavigate.routeConfig,
        NestedNavigate.routeConfig,
      ],
      onUnknownRoute: UnknownNavigate.routeConfig,
      debugLabel: 'main',
    );
  }


```

use Router:

```dart
 final NavmeRouterDelegate _routerDelegate = NavmeRouterDelegate.main();
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