import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:daily_spending_tracker/controllers/theme_controller/theme_controller.dart';
import 'package:daily_spending_tracker/pages/Home/home_page.dart';
import 'package:daily_spending_tracker/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreservingBottomNavState extends StatefulWidget {
  const PreservingBottomNavState({Key? key}) : super(key: key);

  @override
  _PreservingBottomNavStateState createState() =>
      _PreservingBottomNavStateState();
}

class _PreservingBottomNavStateState extends State<PreservingBottomNavState> {
  int _selectedIndex = 1;

  static final List<Widget> _pages = <Widget>[SettingsPage(), HomePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Consumer<ThemeController>(
          builder: (context, ThemeController themeNotifier, child) {
        return CurvedNavigationBar(
          animationDuration: const Duration(milliseconds: 500),
          //work on alternating the different colors. just need to find a good color pallet and go from there.
          //color: themeNotifier.isDark == true ? Colors.grey : Colors.white,
          //backgroundColor: Colors.blue,
          height: 45.5,
          items: const <Widget>[
            Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            Icon(
              Icons.attach_money_outlined,
              color: Colors.black,
            ),
          ],
          index: _selectedIndex,
          onTap: _onItemTapped,
        );
      }),
    );
  }
}
