import 'package:flutter/material.dart';

@immutable
class Book {
  Book(this.title, this.author);
  final String title;
  final String author;

  @override
  String toString() {
    return 'Book : title = $title, author = $author';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Book && other.title == title && other.author == author;
  }

  @override
  int get hashCode => title.hashCode ^ author.hashCode;
}
