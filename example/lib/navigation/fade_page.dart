import 'package:flutter/material.dart';

// This is our custom page
class FadePage extends Page {
  FadePage({required this.child, LocalKey? key}) : super(key: key);
  final Widget child;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
