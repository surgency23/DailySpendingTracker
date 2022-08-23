import 'payroll_frequency_preferences.dart';
import 'package:flutter/material.dart';

class FrequencyController extends ChangeNotifier {
  late FrequencyPreferences _frequencyPreferences;
  late int _frequency;

  int get frequency => _frequency;

  FrequencyController() {
    _frequency =
        1; // 365(Daily), 52(Weekly), 26(Bi-Weekly), 24(Semi-Monthly), 12(Monthy), 4(Quarterly), 2(Semi-Annually), 1(Annually)
    _frequencyPreferences = FrequencyPreferences();
    getPreferences();
  }

  //setting frequency's value
  set frequency(int value) {
    _frequency = value;
    notifyListeners();
  }

  getPreferences() async {
    _frequency = await _frequencyPreferences.getFrequency();
    notifyListeners();
  }
}
