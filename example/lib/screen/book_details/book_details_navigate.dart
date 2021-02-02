import 'package:flutter/material.dart';
import 'package:navme/navme.dart';

import '../../model/index.dart';
import '../books_list/index.dart';
import 'index.dart';

class BookDetailsNavigate {
  static String path = 'book';
  static RouteConfig routeConfig = RouteConfig(
    state: (Uri uri) =>
        RouteState(uri: '$path?${settings(RouteState(uri: uri))}'.toUri()),
    isThisPage: (RouteState state) {
      if (state?.firstPath == path && settings(state) != null) {
        return true;
      }
      return false;
    },
    settings: settings,
    page: page,
  );

  static Map<String, String> settings(RouteState state) {
    if (state == null) {
      return null;
    }
    // book/1
    var id = state.uri?.pathSegments?.length == 2
        ? state.uri?.pathSegments[1]
        : null;
    // book?id=1
    id ??= state.getQueryValue('id');
    if (id == null) {
      return null;
    }
    return {'id': id};
  }

  static MaterialPage page({RouteState state}) {
    final settings = routeConfig.settings(state);
    final id = int.tryParse(settings['id']?.toString());
    Book book;
    if (id != null) {
      book = BooksListScreen.allBooks.length > id
          ? BooksListScreen.allBooks[id]
          : null;
    }
    return MaterialPage(
      key: ValueKey('BookDetailsPageId$id'),
      child: BookDetailsScreen(book: book),
      arguments: settings,
      name: 'BookDetailsScreen',
    );
  }

  static Uri getUri(Book book) {
    final index = BooksListScreen.allBooks.indexOf(book);
    return 'book?id=$index'.toUri();
  }
}
