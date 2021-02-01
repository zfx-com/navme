# navme by zfx.com

[![Pub](https://img.shields.io/pub/v/navme.svg)](https://pub.dev/packages/navme)

A simple way to use Navigation 2.0 like Navigator 1.0 and simple config for each page
Navigation with focus on support web URL.

live demo: https://zfx-com.github.io/navme/

## Import

```yaml
navme: 0.9.3
```

```dart
import 'package:navme/navme.dart';
```

## Example use

Example config for page:

```dart
 // config page
 class BooksListNavigate {
  // base path
  static String path = 'book';

  // config for configurate Router
  static RouteConfig routeConfig = RouteConfig(
    state: RouteState(uri: path.toUri()),
    // condition for using this page
    isThisPage: (RouteState state) {
      if ((state?.firstPath == path || state?.uri?.pathSegments?.isEmpty == true) && !state.hasParams) {
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
      return MaterialPage(key: const ValueKey('BooksListPage'), child: BooksListScreen.all(), name: 'BooksListScreen');
    },
  );
}
```

Implementation BaseRouterDelegate for your configuration

```dart
class NavmeRouterDelegate extends BaseRouterDelegate {
  NavmeRouterDelegate()
      : super(
          // base route
          initConfig: BooksListNavigate.routeConfig,
          configs: [
            // pages
            BookDetailsNavigate.routeConfig,
            BooksListNavigate.routeConfig,
            FadeNavigate.routeConfig,
            NestedNavigate.routeConfig,
            UnknownNavigate.routeConfig,
          ],
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

### Todo:

- return url
- nested url
- open dialog
