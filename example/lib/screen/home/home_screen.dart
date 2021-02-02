import 'package:flutter/material.dart';

import 'package:navme/helpers.dart';
import 'package:navme/navme.dart';

import '../../navigation/index.dart';
import '../books_list/index.dart';
import '../fade/index.dart';
import '../nested/index.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                  title: const Text('Books'),
                  onTap: () {
                    BaseRouterDelegate.of(context)
                        ?.push(BooksListNavigate.path.toUri());
                  }),
              ListTile(
                  title: const Text('Fade'),
                  onTap: () {
                    BaseRouterDelegate.of(context)
                        ?.push(FadeNavigate.path.toUri());
                  }),
              ListTile(
                  title: const Text('Nested'),
                  onTap: () {
                    BaseRouterDelegate.of(context)
                        ?.push(NestedNavigate.path.toUri());
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
