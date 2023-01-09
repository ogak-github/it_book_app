import 'package:it_engineer_books/models/simple_book.dart';

class SearchBook {
  String? total;
  String? page;
  List<SimpleBook> books;

  SearchBook({
    this.total,
    this.page,
    this.books = const [],
  });

  factory SearchBook.fromJson(Map<String, dynamic> json) {
    final books = <SimpleBook>[];
    if (json['books'] != null) {
      for (var book in json['books']) {
        books.add(SimpleBook.fromJson(book));
      }
    }
    return SearchBook(
      total: json['total'],
      page: json['page'],
      books: books,
    );
  }
}
