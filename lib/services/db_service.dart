import 'package:it_engineer_books/models/book.dart';
import 'package:it_engineer_books/models/sqlite_repository.dart';
import 'package:it_engineer_books/sqlite/app_database.dart';

class DbService extends SqliteRepository {
  final db = AppDatabase.instance;

  @override
  Future<int> addToBookmark(Book book) {
    return Future(() async {
      final isbn13 = await db.addToBookmark(book);
      return isbn13;
    });
  }

  @override
  void close() {
    db.close();
  }

  @override
  Future<int?> findBookmarkByIsbn13(int isbn13) async {
    return await db.findBookmarkByIsbn13(isbn13);
  }

  @override
  Future<List<Book>> getAllBookmark() async {
    return await db.findAllBookmark();
  }

  @override
  Future init() {
    return Future.value();
  }

  @override
  Future<void> removeBookmark(Book book) {
    db.removeBookmark(book);
    return Future.value();
  }
}
