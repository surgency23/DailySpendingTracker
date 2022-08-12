import 'package:shared_preferences/shared_preferences.dart';

class DailyTotalPreferences {
  static const PREF_KEY = "dailyTotal";

  setTotal(double value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble(PREF_KEY, value);
  }

  getTotal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(PREF_KEY) ?? 0.00;
  }
}
