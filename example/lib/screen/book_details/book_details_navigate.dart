import 'package:flutter/material.dart';
import 'package:navme/helpers.dart';
import 'package:navme/navme.dart';

import '../../model/index.dart';
import '../books_list/index.dart';
import 'index.dart';

class BookDetailsNavigate {
  static String path = 'book';

  static const String behaviorKey = 'behavior_key';
  static const String innerMessageKey = 'inner_message_key';

  static RouteConfig routeConfig = RouteConfig(
    state: (Uri? uri) =>
        RouteState(uri: '$path?${settings(RouteState(uri: uri))}'.toUri()),
    isThisPage: (RouteState state) {
      if (state.firstPath == path && settings(state) != null) {
        return true;
      }
      return false;
    },
    settings: settings,
    page: page,
  );

  static Map<String, String?>? settings(RouteState state) {
    // book/1
    var id =
        state.uri?.pathSegments.length == 2 ? state.uri?.pathSegments[1] : null;
    // book?id=1
    id ??= state.getQueryValue('id');
    // ignore: unnecessary_null_comparison
    if (id == null) {
      return null;
    }
    return {'id': id};
  }

  static MaterialPage page({RouteState? state}) {
    final settings = routeConfig.settings(state!);
    Book? book;
    int? id;
    if (settings != null) {
      id = settings['id']?.toString() == null
          ? null
          : int.tryParse(settings['id'].toString());
      if (id != null) {
        book = BooksListScreen.allBooks.length > id
            ? BooksListScreen.allBooks[id]
            : null;
      }
    }
    String? innerMessage;
    void Function()? behavior;
    final uriMap = state.uriState;
    if (uriMap is Map<String, dynamic>) {
      if (uriMap.containsKey(innerMessageKey)) {
        final staff = uriMap[innerMessageKey];
        if (staff is String) {
          innerMessage = staff;
        }
      }
    }
    final innerMap = state.innerState;
    if (innerMap is Map<String, dynamic>) {
      if (innerMap.containsKey(behaviorKey)) {
        final staff = innerMap[behaviorKey];
        if (staff is void Function()) {
          behavior = staff;
        }
      }
    }
    return MaterialPage(
      key: ValueKey('BookDetailsPageId$id'),
      child: BookDetailsScreen(
        book: book,
        innerMessage: innerMessage,
        behavior: behavior,
      ),
      arguments: settings,
      name: 'BookDetailsScreen',
    );
  }

  static Uri? getUri(Book book) {
    final index = BooksListScreen.allBooks.indexOf(book);
    return 'book?id=$index'.toUri();
  }
}
