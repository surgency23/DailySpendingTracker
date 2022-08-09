import 'package:daily_spending_tracker/controllers/number_controllers/numbers_controller.dart';
import 'package:daily_spending_tracker/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/theme_controller/theme_controller.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NumbersController())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  /// ↓↓ ADDED
  /// InheritedWidget style accessor to our State object.
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

/// State object hidden ↓. Focusing on ↑ StatefulWidget here.

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeController(),
        child: Consumer<ThemeController>(
          builder: ((context, ThemeController themeNotifier, child) {
            return MaterialApp(
                title: "Daily Spending Tracker",
                theme:
                    themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
                debugShowCheckedModeBanner: false,
                home: const HomePage());
          }),
        ));
  }
}
