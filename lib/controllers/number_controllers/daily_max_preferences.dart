import 'package:shared_preferences/shared_preferences.dart';

class MaxPreferences {
  static const PREF_KEY = "dailyMax";

  setMax(double value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble(PREF_KEY, value);
  }

  getMax() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(PREF_KEY) ?? 0.00;
  }
}
