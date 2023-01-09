import 'package:flutter/material.dart';
import 'package:it_engineer_books/app_theme.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting", style: AppTheme.lightTextTheme.headline5),
      ),
      body: Container(
        child: Center(
          child: Text(
            "Setting Page",
            style: AppTheme.lightTextTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
