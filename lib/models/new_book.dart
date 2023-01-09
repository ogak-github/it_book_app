import 'package:it_engineer_books/models/simple_book.dart';

class NewBook {
  String? error;
  String? total;
  List<SimpleBook> books;

  NewBook({
    this.error,
    this.total,
    this.books = const [],
  });

  factory NewBook.fromJson(Map<String, dynamic> json) {
    final books = <SimpleBook>[];
    if (json['books'] != null) {
      for (var book in json['books']) {
        books.add(SimpleBook.fromJson(book));
      }
    }

    return NewBook(
      error: json['error'],
      total: json['total'],
      books: books,
    );
  }
}
