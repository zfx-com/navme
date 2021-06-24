import 'package:navme/navme.dart';
import 'package:flutter/material.dart';

import '../../navigation/index.dart';

class NestedScreen extends StatelessWidget {
  NestedScreen({required NavmeRouterDelegate routerDelegate, Key? key})
      : _routerDelegate = routerDelegate,
        super(key: key);

  final NavmeRouterDelegate _routerDelegate;
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
