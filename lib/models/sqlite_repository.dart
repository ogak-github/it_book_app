import 'package:it_engineer_books/models/book.dart';

abstract class SqliteRepository {
  Future<List<Book>> getAllBookmark();
  Future<int?> findBookmarkByIsbn13(int isbn13);
  Future<int> addToBookmark(Book book);
  Future<void> removeBookmark(Book book);
  Future init();
  void close();
}
