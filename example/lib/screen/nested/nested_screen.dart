import 'package:navme/navme.dart';
import 'package:flutter/material.dart';

import '../../navigation/index.dart';

class NestedScreen extends StatelessWidget {
  NestedScreen({Key key}) : super(key: key);

  final NavmeRouterDelegate _routerDelegate = NavmeRouterDelegate();
  final StateRouteInformationParser _stateRouteInformation =
      StateRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested List'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height / 2,
        child: MaterialApp.router(
          routerDelegate: _routerDelegate,
          routeInformationParser: _stateRouteInformation,
        ),
      ),
    );
  }
}
