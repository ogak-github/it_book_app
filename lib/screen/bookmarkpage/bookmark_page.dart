import 'package:flutter/material.dart';

import 'package:it_engineer_books/app_theme.dart';
import 'package:it_engineer_books/provider/app_state_manager.dart';
import 'package:it_engineer_books/screen/bookmarkpage/bookmark_list_view.dart';
import 'package:provider/provider.dart';

import '../../models/book.dart';

class BookmarkPage extends StatefulWidget {
  BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookmark", style: AppTheme.lightTextTheme.headline5),
      ),
      body: _buildBookmarkList(),
    );
  }

  Widget _buildBookmarkList() {
    final repository = Provider.of<AppStateManager>(context);
    return FutureBuilder(
        future: repository.getAllBookmark(),
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
                child: const Center(child: CircularProgressIndicator()));
          } else {
            if (!snapshot.hasData) {
              return Center(
                  child: Text("No Data",
                      style: AppTheme.lightTextTheme.bodyText1));
            } else if (snapshot.hasError) {
              return Center(
                  child: Text("${snapshot.error}",
                      style: AppTheme.lightTextTheme.bodyText1));
            } else {
              return BookmarkListView(
                bookmarks: snapshot.data!,
              );
            }
          }
        });
  }
}
