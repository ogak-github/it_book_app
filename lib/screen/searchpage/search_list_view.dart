import 'package:flutter/material.dart';
import 'package:it_engineer_books/services/api_service.dart';
import '../../app_theme.dart';
import '../../models/search_book.dart';
import '../../models/simple_book.dart';
import '../detailpage/details_page.dart';

class SearchListView extends StatefulWidget {
  final String searchKeyword;

  SearchListView({Key? key, required this.searchKeyword}) : super(key: key);

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  ApiService apiService = ApiService();
  late Future<SearchBook> apiSearchResult;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    apiSearchResult = apiService.searchBook(widget.searchKeyword);
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool top = _scrollController.position.pixels == 0;
        if (top) {
          print('Scroll position at top');
        } else {
          apiSearchResult = apiService.searchBook(widget.searchKeyword);
          print('Scroll position at bottom');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for: \'${widget.searchKeyword}\''),
      ),
      body: FutureBuilder(
        future: apiSearchResult,
        builder: (BuildContext context, AsyncSnapshot<SearchBook> snapshot) {
          var data = snapshot.data?.books;
          var totalPage = snapshot.data?.total;
          var currentPage = snapshot.data?.page;

          //debugPrint(data.toString());
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Center(
                  child: Text("No books found",
                      style: AppTheme.lightTextTheme.bodyText2));
            } else if (snapshot.hasError) {
              return Center(
                  child: Text("${snapshot.error}",
                      style: AppTheme.lightTextTheme.bodyText2));
            } else {
              return Column(
                children: [
                  Text('Search page: $currentPage of $totalPage',
                      style: AppTheme.lightTextTheme.caption),
                  Expanded(
                    child: listViewBuilder(data!),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }

  Widget listViewBuilder(List<SimpleBook> listBook) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3.5,
      ),
      itemCount: listBook.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            var isbn13 = listBook[index].isbn13;
            int isbn13toInt = int.parse(isbn13!);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BookDetails(isbn13: isbn13toInt),
              ),
            );
          },
          child: listGridView(listBook[index]),
        );
      },
    );
  }

  Widget listGridView(SimpleBook listBook) {
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
                  maxLines: 2,
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
