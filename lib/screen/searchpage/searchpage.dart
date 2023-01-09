import 'dart:math';

import 'package:flutter/material.dart';
import 'package:it_engineer_books/app_theme.dart';
import 'package:it_engineer_books/models/simple_book.dart';
import 'package:it_engineer_books/screen/searchpage/search_list_view.dart';
import 'package:it_engineer_books/screen/searchpage/search_result.dart';
import 'package:it_engineer_books/services/api_service.dart';
import '../../models/search_book.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiService apiService = ApiService();

  final List<String> _hintText = [
    'Python for beginner',
    'Java for dummies',
    'Android development',
    'Webserver',
    'Javascript',
    'iOS development',
    'Web development',
    'Cross-platform'
  ];
  TextEditingController searchKeyword = TextEditingController();

  @override
  void dispose() {
    searchKeyword.dispose();
    super.dispose();
  }

  String randomHintTextGenerator() {
    int result = Random().nextInt(_hintText.length);
    return _hintText[result];
  }

  submittedSearch(String value) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SearchListView(searchKeyword: value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: searchField(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
          future: apiService.searchBook(searchKeyword.text),
          builder: (BuildContext context, AsyncSnapshot<SearchBook> snapshot) {
            var data = snapshot.data?.books;
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
                return SearchResult(searchResult: data!);
              }
            }
          },
        ),
      ),
    );
  }

  Widget _searchResultBuilder(String query) {
    return FutureBuilder(
        future: apiService.searchBook(query),
        builder: (BuildContext context, AsyncSnapshot<SearchBook> snapshot) {
          var data = snapshot.data?.books;
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
              return SearchResult(searchResult: data!);
            }
          }
        });
  }

  Widget searchResult(List<SimpleBook> listBook) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listBook.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "${listBook[index].title}",
              style: AppTheme.lightTextTheme.bodyText1,
            ),
          );
        });
  }

  Widget searchField() {
    return SizedBox(
      height: 43,
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchResultBuilder(value);
          });
        },
        onSubmitted: (value) {
          value.isEmpty ? null : submittedSearch(value);
        },
        textInputAction: TextInputAction.search,
        controller: searchKeyword,
        autofocus: true,
        style: AppTheme.lightTextTheme.bodyText1,
        decoration: InputDecoration(
          focusColor: Colors.black,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: randomHintTextGenerator(),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              searchKeyword.text.isEmpty
                  ? null
                  : submittedSearch(searchKeyword.text);
            },
            icon: const Icon(Icons.send_outlined, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
