import 'package:flutter/material.dart';

class FadeScreen extends StatelessWidget {
  FadeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade'),
      ),
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              for (var i = 0; i < 10; i++)
                ListTile(
                  title: Text('Fade $i'),
                )
            ],
          ),
        ],
      ),
    );
  }
}
