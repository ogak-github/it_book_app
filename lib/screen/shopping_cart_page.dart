import 'package:flutter/material.dart';
import 'package:it_engineer_books/app_theme.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: AppTheme.lightTextTheme.headline5),
      ),
      body: Container(
        child: Center(
          child: Text('Shopping Cart Page',
              style: AppTheme.lightTextTheme.bodyText1),
        ),
      ),
    );
  }
}
