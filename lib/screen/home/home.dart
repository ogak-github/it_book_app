import 'package:flutter/material.dart';
import 'package:it_engineer_books/app_theme.dart';
import 'package:it_engineer_books/screen/home/list_new_book.dart';
import 'package:it_engineer_books/screen/searchpage/searchpage.dart';
import 'package:it_engineer_books/services/api_service.dart';
import 'package:provider/provider.dart';
import '../../provider/app_state_manager.dart';
import '../../models/new_book.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ApiService apiService = ApiService();
  late Future<NewBook> apiNewBook;

  @override
  void initState() {
    apiNewBook = apiService.getNewBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appStateManager = Provider.of<AppStateManager>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:
            Text("IT Engineer Books", style: AppTheme.lightTextTheme.headline5),
        actions: [
          IconButton(
            onPressed: () {
              appStateManager.changeToGridView();
            },
            icon: appStateManager.gridView
                ? const Icon(Icons.grid_view)
                : const Icon(Icons.list),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage()));
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: _itemBuilder(),
      ),
    );
  }

  Widget _itemBuilder() {
    return FutureBuilder(
      future: apiNewBook,
      builder: (BuildContext context, AsyncSnapshot<NewBook> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return Center(
                child:
                    Text("No Data", style: AppTheme.lightTextTheme.bodyText2));
          } else {
            return ListNewBook(listBook: snapshot.data!.books);
          }
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: CircularProgressIndicator())),
            ],
          );
        }
      },
    );
    /*return Consumer<AppStateManager>(builder: (context, service, child) {
      return FutureBuilder(
        future: service.getBooks(),
        builder: (BuildContext context, AsyncSnapshot<NewBook> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return Center(
                  child: Text("No Data",
                      style: AppTheme.lightTextTheme.bodyText2));
            } else {
              return ListNewBook(listBook: snapshot.data!.books);
            }
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(child: CircularProgressIndicator())),
              ],
            );
          }
        },
      );
    });*/
  }

  @override
  bool get wantKeepAlive => true;
}
