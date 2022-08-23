import 'package:shared_preferences/shared_preferences.dart';

class FrequencyPreferences {
  static const PREF_KEY = "payFrequency";

  setFrequency(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(PREF_KEY, value);
  }

  getFrequency() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(PREF_KEY) ?? 1;
  }
}
