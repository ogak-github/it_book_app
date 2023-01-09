import 'package:flutter/material.dart';
import 'package:it_engineer_books/screen/detailpage/details_page.dart';

import '../../app_theme.dart';
import '../../models/simple_book.dart';

class SearchResult extends StatefulWidget {
  final List<SimpleBook> searchResult;
  const SearchResult({Key? key, required this.searchResult}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  late List<SimpleBook> _searchResult;
  @override
  void initState() {
    _searchResult = widget.searchResult;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: _searchResult.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              var isbn13 = _searchResult[index].isbn13;
              int isbn13toInt = int.parse(isbn13!);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BookDetails(isbn13: isbn13toInt),
                ),
              );
            },
            child: ListTile(
              leading: Image.network(
                "${_searchResult[index].image}",
                scale: 1,
                fit: BoxFit.cover,
              ),
              title: Text(
                "${_searchResult[index].title}",
                style: AppTheme.lightTextTheme.subtitle1,
              ),
            ),
          );
        },
      ),
    );
  }
}
