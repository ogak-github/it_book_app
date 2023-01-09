import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:it_engineer_books/screen/bookmarkpage/bookmark_page.dart';

import 'package:it_engineer_books/screen/setting_page.dart';
import 'package:it_engineer_books/screen/shopping_cart_page.dart';

import 'home/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  static List<Widget> pages = <Widget>[
    Home(),
    BookmarkPage(),
    const ShoppingCartPage(),
    const SettingPage(),
  ];

  @override
  void initState() {
    pages;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: /*pages[currentPageIndex]*/ IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        height: 72,
        width: 319,
        margin: const EdgeInsets.only(bottom: 24, left: 34, right: 34),
        child: CustomNavigationBar(
          iconSize: 24,
          elevation: 0.8,
          strokeColor: Colors.black,
          selectedColor: Colors.black,
          unSelectedColor: const Color(0xFF9C9EA8),
          borderRadius: const Radius.circular(22),
          backgroundColor: Colors.white,
          isFloating: true,
          currentIndex: currentPageIndex,
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
              print(currentPageIndex);
            });
          },
          items: [
            CustomNavigationBarItem(
              icon: const Icon(Icons.home_filled),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.bookmark_border_outlined),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart_rounded),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
