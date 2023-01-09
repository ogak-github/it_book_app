import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:it_engineer_books/app_theme.dart';
import 'package:it_engineer_books/provider/app_state_manager.dart';
import 'package:it_engineer_books/models/book.dart';
import 'package:it_engineer_books/screen/detailpage/book_page.dart';
import 'package:it_engineer_books/services/api_service.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatelessWidget {
  BookDetails({Key? key, required this.isbn13}) : super(key: key);
  final int isbn13;

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bookDetailsBuilder(context, isbn13),
    );
  }

  Widget _bookDetailsBuilder(BuildContext context, int isbn13) {
    return FutureBuilder(
      future: apiService.findBookByIsbn13(isbn13),
      builder: (BuildContext context, AsyncSnapshot<Book> snapshot) {
        var data = snapshot.data;

        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
              child: const Center(child: CircularProgressIndicator()));
        } else {
          if (!snapshot.hasData) {
            return Center(
                child:
                    Text("No Data", style: AppTheme.lightTextTheme.bodyText1));
          } else if (snapshot.hasError) {
            return Center(
                child: Text("${snapshot.error}",
                    style: AppTheme.lightTextTheme.bodyText1));
          } else {
            return BookPage(book: data!);
          }
        }
      },
    );
  }
}
