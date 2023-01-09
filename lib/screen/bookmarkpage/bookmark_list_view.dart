import 'package:flutter/material.dart';
import 'package:it_engineer_books/screen/detailpage/details_page.dart';
import 'package:provider/provider.dart';

import '../../models/book.dart';
import '../../provider/app_state_manager.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BookmarkListView extends StatelessWidget {
  List<Book> bookmarks = [];
  BookmarkListView({Key? key, required this.bookmarks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<AppStateManager>(context);
    return ListView.builder(
      itemCount: bookmarks.length,
      itemBuilder: (context, int index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                flex: 1,
                onPressed: (BuildContext context) {
                  repository.removeCurrentBookmark(bookmarks[index]);
                },
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                icon: Icons.delete_outlined,
                label: "Delete",
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => BookDetails(
                        isbn13: int.parse(bookmarks[index].isbn13.toString()))),
              );
            },
            child: ListTile(
              leading: Image.network(
                "${bookmarks[index].image}",
                scale: 1,
                fit: BoxFit.cover,
              ),
              title: Text(bookmarks[index].title),
            ),
          ),
        );
      },
    );
  }
}
