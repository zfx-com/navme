// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:navme/navme.dart';
import 'package:navme/helpers.dart';

// ignore: avoid_relative_lib_imports
import '../lib/navigation/index.dart';

void main() {
  test('book detail set', () async {
    final navmeRouterDelegate = NavmeRouterDelegate.main();
    var pages = navmeRouterDelegate.buildPage();
    expect(pages.length == 1, true);
    await navmeRouterDelegate
        .setNewRoutePath(RouteState(uri: 'book?id=1'.toUri()));
    expect(navmeRouterDelegate.pages.length == 2, true);
    navmeRouterDelegate.pop();
    expect(navmeRouterDelegate.pages.length == 1, true);
    expect(navmeRouterDelegate.currentState.uri.toString() == 'book', true);
    navmeRouterDelegate.pop(removeLast: true);
    expect(navmeRouterDelegate.pages.isEmpty, true);
    pages = navmeRouterDelegate.buildPage();
    expect(navmeRouterDelegate.currentState.uri.toString() == '/', true);
  });

  test('nested', () async {
    final navmeRouterDelegate = NavmeRouterDelegate.main();
    final pages = navmeRouterDelegate.buildPage();
    expect(pages.length == 1, true);
    await navmeRouterDelegate
        .setNewRoutePath(RouteState(uri: 'nested'.toUri()));
    expect(navmeRouterDelegate.pages.length == 1, true,
        reason: navmeRouterDelegate.pages.toString());
    navmeRouterDelegate.pop();
    expect(navmeRouterDelegate.pages.length == 1, true,
        reason: navmeRouterDelegate.pages.toString());
    expect(navmeRouterDelegate.currentState.uri.toString() == 'nested', true,
        reason: navmeRouterDelegate.currentState.uri.toString());
  });
}
