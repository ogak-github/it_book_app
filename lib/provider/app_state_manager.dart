import 'package:flutter/material.dart';
import 'package:it_engineer_books/models/shared_pref_repository.dart';
import 'package:it_engineer_books/services/db_service.dart';
import '../models/book.dart';
import '../models/new_book.dart';

class AppStateManager extends ChangeNotifier {
  final _dbService = DbService();
  bool _gridView = false;
  bool isLoading = false;
  bool get gridView => _gridView;
  late Future<NewBook> _listNewBook;
  get listNewBook => _listNewBook;
  late List<Book> _bookmarks;
  get bookmark => _bookmarks;

  void changeToGridView() {
    _gridView = !_gridView;
    notifyListeners();
  }

  void addToBookmark(Book book) {
    var id = int.parse(book.isbn13.toString());

    checkBookmark(id).then(
      (value) {
        if (value != true) {
          _dbService.addToBookmark(book);
          notifyListeners();
        }
      },
    );
  }

  void removeCurrentBookmark(Book book) {
    removeFromBookmark(book).then((value) {
      notifyListeners();
    });
  }

  Future<bool> checkBookmark(int id) async {
    if ((await getBookmark(id))! > 1) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<int?> getBookmark(int isbn13) {
    return _dbService.findBookmarkByIsbn13(isbn13);
  }

  Future<void> removeFromBookmark(Book book) {
    return _dbService.removeBookmark(book);
  }

  Future<List<Book>> getAllBookmark() {
    return _dbService.getAllBookmark();
  }
}
