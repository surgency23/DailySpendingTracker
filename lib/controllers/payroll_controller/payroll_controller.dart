import 'payroll_frequency_preferences.dart';
import 'package:flutter/material.dart';

class FrequencyController extends ChangeNotifier {
  // "365(Daily)" || 52(Weekly), 26(Bi-Weekly), 24(Semi-Monthly), 12(Monthy), 4(Quarterly), 2(Semi-Annually), 1(Annually)"

  late FrequencyPreferences _frequencyPreferences;
  late String _frequency;
  String get frequency => _frequency;

  List<String> get options => [
        "Daily",
        "Weekly",
        "Bi-Weekly",
        "Semi-Monthly",
        "Monthly",
        "Quarterly",
        "Semi-Annually",
        "Annually"
      ];

  FrequencyController() {
    _frequency =
        "Bi-Weekly!"; // 365(Daily), 52(Weekly), 26(Bi-Weekly), 24(Semi-Monthly), 12(Monthy), 4(Quarterly), 2(Semi-Annually), 1(Annually)
    _frequencyPreferences = FrequencyPreferences();
    getPreferences();
  }

  //setting frequency's value
  set frequency(String value) {
    _frequency = value;
    notifyListeners();
  }

  getPreferences() async {
    _frequency = await _frequencyPreferences.getFrequency();
    notifyListeners();
  }
}
