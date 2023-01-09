import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart';

import '../models/book.dart';

class AppDatabase {
  static const _databaseName = 'itbook.db';
  static const _databaseVersion = 1;
  static const bookmarkTable = 'bookmark';
  static const isbn13 = 'isbn13';

  static late BriteDatabase _streamDatabase;
  AppDatabase._privateConstructor();

  static final AppDatabase instance = AppDatabase._privateConstructor();
  static var lock = Lock();

  static Database? _database;

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $bookmarkTable (
        title TEXT,
        subtitle TEXT,
        authors TEXT,
        publisher TEXT,
        isbn10 TEXT,
        $isbn13 TEXT PRIMARY KEY,
        pages TEXT,
        year TEXT,
        rating TEXT,
        price TEXT,
        desc TEXT,
        image TEXT,
        url TEXT
      )
    ''');
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    Sqflite.setDebugModeOn(true);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    await lock.synchronized(
      () async {
        if (_database == null) {
          _database = await _initDatabase();
          _streamDatabase = BriteDatabase(_database!);
        }
      },
    );
    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  List<Book> parseBook(List<Map<String, dynamic>> listBookmark) {
    final books = <Book>[];
    for (var items in listBookmark) {
      final item = Book.fromJson(items);
      books.add(item);
    }
    return books;
  }

  Future<List<Book>> findAllBookmark() async {
    final db = await instance.streamDatabase;
    final bookmarkList = await db.query(bookmarkTable);
    final bookmarks = parseBook(bookmarkList);
    return bookmarks;
  }

  Future<Book> findBookByIsbn13() async {
    final db = await instance.streamDatabase;
    final bookmarkList =
        await db.query(bookmarkTable, where: 'isbn13 = $isbn13');
    final bookmark = parseBook(bookmarkList);
    return bookmark.first;
  }

  Future<int?> findBookmarkByIsbn13(int isbn) async {
    final db = await instance.streamDatabase;
    //final bookmarkList = await db.query(bookmarkTable, where: 'isbn13 = $isbn');
    int? count = Sqflite.firstIntValue(await db
        .rawQuery("SELECT COUNT(*) FROM $bookmarkTable WHERE $isbn13 = $isbn"));
    return count;
  }

  Future<int> add(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    return db.insert(table, row);
  }

  Future<int> addToBookmark(Book book) {
    return add(bookmarkTable, book.toJson());
  }

  Future<int> _remove(String table, String columnId, String isbn13) async {
    final db = await instance.streamDatabase;
    return db.delete(table, where: '$columnId = ?', whereArgs: [isbn13]);
  }

  Future<int> removeBookmark(Book book) async {
    var id = book.isbn13;
    if (id != null) {
      return _remove(bookmarkTable, isbn13, id);
    } else {
      return Future.value(-1);
    }
  }

  void close() {
    _streamDatabase.close();
  }
}
