import 'package:shared_preferences/shared_preferences.dart';

class CurrentTotalPreferences {
  static const PREF_KEY = "currentTotal";

  setTotal(double value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble(PREF_KEY, value);
  }

  getTotal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(PREF_KEY) ?? 0.00;
  }
}
