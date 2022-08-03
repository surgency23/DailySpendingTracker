import 'package:flutter/material.dart';
import 'theme_preferences.dart';

class ThemeController extends ChangeNotifier {
  late bool _isDark;
  late ThemePreferences _preferences;
  bool get isDark => _isDark;

  ThemeController() {
    _isDark = false;
    _preferences = ThemePreferences();
    getPreferences();
  }

//Switching themes in the flutter apps - Flutterant
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}
