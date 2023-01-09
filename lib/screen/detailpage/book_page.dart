import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:it_engineer_books/provider/app_state_manager.dart';
import 'package:it_engineer_books/models/book.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class BookPage extends StatefulWidget {
  final Book book;

  const BookPage({Key? key, required this.book}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late bool bookmark;
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<AppStateManager>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              //appStateManager.addToBookmark();
              setState(() {
                bookmark = !bookmark;
                if (!bookmark) {
                  repository.removeCurrentBookmark(widget.book);
                } else {
                  repository.addToBookmark(widget.book);
                }
                //repository.addToBookmark(widget.book);
              });
            },
            icon: _bookmarkCheck(),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(right: 28, left: 28, top: 5, bottom: 5),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Image.network('${widget.book.image}'),
                Text(
                  widget.book.title,
                  style: AppTheme.lightTextTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "${widget.book.authors}",
                  style: AppTheme.lightTextTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ratingBarIndicator(int.parse("${widget.book.rating}")),
                    const SizedBox(width: 12),
                    Text("${widget.book.rating}",
                        style: AppTheme.lightTextTheme.bodyText2),
                    Text("/", style: AppTheme.lightTextTheme.bodyText2),
                    Text("5", style: AppTheme.lightTextTheme.bodyText2),
                  ],
                ),
                const SizedBox(height: 16),
                Text("${widget.book.desc}",
                    style: AppTheme.lightTextTheme.bodyText2),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 154,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.text_snippet_outlined),
                        label: const Text("Preview"),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 154,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chat_outlined),
                        label: const Text("Review"),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 36, bottom: 36),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Buy Now for ${widget.book.price}")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _ratingBarIndicator(int bookRating) {
    return RatingBarIndicator(
      rating: double.parse(bookRating.toString()),
      itemCount: 5,
      itemSize: 21,
      itemBuilder: (context, index) {
        return const Icon(Icons.star, color: Color(0xFFFFC41F));
      },
    );
  }

  Widget _bookmarkCheck() {
    final repos = Provider.of<AppStateManager>(context, listen: false);
    return FutureBuilder(
      future: repos.getBookmark(int.parse(widget.book.isbn13.toString())),
      builder: (context, AsyncSnapshot<int?> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Icon(Icons.bolt_outlined);
        } else {
          if (!snapshot.hasData) {
            return const Icon(Icons.bookmark_border);
          } else if (snapshot.hasError) {
            return const Icon(Icons.bookmark_remove);
          } else {
            if (snapshot.data! > 0) {
              bookmark = true;
              return const Icon(Icons.bookmark);
            } else {
              bookmark = false;
              return const Icon(Icons.bookmark_border);
            }
          }
        }
      },
    );
  }
}
