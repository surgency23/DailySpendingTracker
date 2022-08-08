import 'package:shared_preferences/shared_preferences.dart';

class TimeStampPreferences {
  static const PREF_KEY = "updatedTimeStamp";

  setTimeStamp(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PREF_KEY, value);
  }

  getTimeStamp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PREF_KEY) ?? DateTime.now().toString();
  }
}
