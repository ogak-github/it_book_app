import 'package:dio/dio.dart';
import 'package:it_engineer_books/models/book.dart';
import 'package:it_engineer_books/models/repository.dart';
import 'package:it_engineer_books/models/search_book.dart';
import '../models/new_book.dart';

class ApiService extends Repository {
  final String _apiUrl = "https://api.itbook.store/1.0";

  @override
  Future<Book> findBookByIsbn13(int isbn13) async {
    //isbn13 = 9781617294136;
    try {
      var response = await Dio().get("$_apiUrl/books/$isbn13");
/*      print(response.statusMessage);
      print(response.data);*/
      return Book.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<NewBook> getNewBook() async {
    try {
      var response = await Dio().get("$_apiUrl/new");
      print("${response.statusCode} ${response.statusMessage}");
      return NewBook.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SearchBook> searchBook(String query, {int page = 1}) async {
    try {
      var response = await Dio().get("$_apiUrl/search/$query/$page");
      //print(response.data);
      return SearchBook.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void close() {}

  @override
  Future init() {
    return Future.value(null);
  }
}
