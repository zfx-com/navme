import 'package:flutter/material.dart';

import '../../model/index.dart';

class BookDetailsScreen extends StatelessWidget {
  BookDetailsScreen({
    @required this.book,
    Key key,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
            if (book == null) const Text('Book not found'),
          ],
        ),
      ),
    );
  }
}
