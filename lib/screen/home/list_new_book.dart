import 'package:flutter/material.dart';
import 'package:it_engineer_books/provider/app_state_manager.dart';
import 'package:it_engineer_books/models/simple_book.dart';
import 'package:provider/provider.dart';
import '../../app_theme.dart';
import '../detailpage/details_page.dart';

class ListNewBook extends StatefulWidget {
  final List<SimpleBook> listBook;

  const ListNewBook({Key? key, required this.listBook}) : super(key: key);

  @override
  State<ListNewBook> createState() => _ListNewBookState();
}

class _ListNewBookState extends State<ListNewBook> {
  AppStateManager appStateManager = AppStateManager();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    //favorite;
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool top = _scrollController.position.pixels == 0;
        if (top) {
          print('Scroll position at top');
        } else {
          print('Scroll position at bottom');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(builder: (context, appState, child) {
      var currentView = appState.gridView;
      return Container(
        height: MediaQuery.of(context).size.height,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: currentView
              ? ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.listBook.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        var isbn13 = widget.listBook[index].isbn13;
                        int isbn13toInt = int.parse(isbn13!);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BookDetails(isbn13: isbn13toInt),
                          ),
                        );
                      },
                      child: listTileNewBook(widget.listBook[index]),
                    );
                  },
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.85,
                  ),
                  itemCount: widget.listBook.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        var isbn13 = widget.listBook[index].isbn13;
                        int isbn13toInt = int.parse(isbn13!);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BookDetails(isbn13: isbn13toInt),
                          ),
                        );
                      },
                      child: listGridView(widget.listBook[index]),
                    );
                  },
                ),
        ),
      );
    });
  }

  listNewBook(SimpleBook listBook) {
    return Container(
      height: 105,
      width: 319,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network('${listBook.image}'),
          const SizedBox(width: 16),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${listBook.title}",
                  style: AppTheme.lightTextTheme.bodyText1,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                Text(
                  "${listBook.subtitle}",
                  style: AppTheme.lightTextTheme.caption,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          /*favorite
              ? const Icon(Icons.bookmark)
              : const Icon(Icons.bookmark_border),*/
        ],
      ),
    );
  }

  listTileNewBook(SimpleBook lists) {
    return ListTile(
      leading: Image.network(
        "${lists.image}",
        scale: 1,
        fit: BoxFit.cover,
      ),
      title: Text(
        "${lists.title}",
        style: AppTheme.lightTextTheme.subtitle1,
      ),
      subtitle: Text(
        "${lists.subtitle}",
        style: AppTheme.lightTextTheme.subtitle2,
      ),
/*      trailing: IconButton(
        onPressed: () {
          setState(() {
            favorite = !favorite;
          });
          debugPrint(favorite.toString());
        },
        icon: favorite
            ? const Icon(Icons.bookmark)
            : const Icon(Icons.bookmark_border),
      ),*/
    );
  }

  listGridView(SimpleBook listBook) {
    return Card(
      child: Column(
        children: [
          Image.network("${listBook.image}"),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "${listBook.title}",
                  style: AppTheme.lightTextTheme.subtitle1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  "${listBook.subtitle}",
                  style: AppTheme.lightTextTheme.overline,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
