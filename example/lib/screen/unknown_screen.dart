import 'package:flutter/material.dart';
import 'package:navme/navme.dart';
import 'package:navme/helpers.dart';

class UnknownNavigate {
  static String path = 'unknown';
  static RouteConfig routeConfig = RouteConfig(
    state: (Uri uri) => RouteState(uri: path.toUri()),
    isThisPage: (RouteState state) {
      return true;
    },
    settings: (RouteState state) {
      return null;
    },
    page: ({RouteState state}) {
      return MaterialPage(
        key: const ValueKey('UnknownPage'),
        child: UnknownScreen(),
        name: 'UnknownScreen',
      );
    },
  );
}

class UnknownScreen extends StatelessWidget {
  UnknownScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('404!'),
      ),
    );
  }
}
