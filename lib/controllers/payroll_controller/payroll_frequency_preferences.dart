import 'package:shared_preferences/shared_preferences.dart';

class FrequencyPreferences {
  static const PREF_KEY = "payFrequency";

  setFrequency(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PREF_KEY, value);
  }

  getFrequency() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PREF_KEY) ?? "Bi-Weekly";
  }
}
