import 'package:it_engineer_books/models/search_book.dart';

import 'book.dart';
import 'new_book.dart';

abstract class Repository {
  Future<NewBook> getNewBook();
  Future<Book> findBookByIsbn13(int isbn13);
  Future<SearchBook> searchBook(String query, {int page});
  Future init();
  void close();
}
