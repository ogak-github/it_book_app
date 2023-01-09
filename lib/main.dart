import 'package:flutter/material.dart';
import 'package:it_engineer_books/app_theme.dart';
import 'package:it_engineer_books/provider/app_state_manager.dart';
import 'package:it_engineer_books/screen/main_screen.dart';
import 'package:it_engineer_books/services/db_service.dart';
import 'package:provider/provider.dart';

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await NosqlService().initialize();
  await Hive.openBox<SimpleBook>('bookmark_box');*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appStateManager = AppStateManager();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _appStateManager, lazy: false),
      ],
      child: MaterialApp(
        title: 'IT Book',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const MainScreen(),
      ),
    );
  }
}
