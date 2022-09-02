import 'package:shared_preferences/shared_preferences.dart';

class PayDatePreferences {
  static const PREF_KEY = "payDate";

  setDate(DateTime value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PREF_KEY, value.toString());
  }

  getDate() async {
    //get the date, assume its a bi weekly pay period. will be overridden once someone sets a different duration
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PREF_KEY) ??
        DateTime.now().add(const Duration(days: 14));
  }
}
