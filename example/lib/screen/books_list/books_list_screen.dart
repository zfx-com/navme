import 'package:navme/helpers.dart';
import 'package:navme/navme.dart';
import 'package:flutter/material.dart';

import '../../model/index.dart';
import '../../navigation/index.dart';
import '../book_details/index.dart';
import '../fade/index.dart';
import '../nested/index.dart';

class BooksListScreen extends StatelessWidget {
  BooksListScreen({@required this.books, Key key}) : super(key: key);

  factory BooksListScreen.all() => BooksListScreen(
        books: allBooks,
      );

  final List<Book> books;

  // for pop on User Page, to possibly go back to a specific book
  static List<Book> allBooks = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List'),
      ),
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              for (var book in books)
                ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    onTap: () {
                      BaseRouterDelegate.of(context)
                          ?.push(BookDetailsNavigate.getUri(book));
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
