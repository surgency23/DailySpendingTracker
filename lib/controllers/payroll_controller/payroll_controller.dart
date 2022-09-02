import 'pay_date_preferences.dart';
import 'payroll_frequency_preferences.dart';
import 'package:flutter/material.dart';

class FrequencyController extends ChangeNotifier {
  // "365(Daily)" || 52(Weekly), 26(Bi-Weekly), 24(Semi-Monthly), 12(Monthy), 4(Quarterly), 2(Semi-Annually), 1(Annually)"

  late FrequencyPreferences _frequencyPreferences;
  late PayDatePreferences _payDatePreferences;
  late DateTime _payDate;
  late String _frequency;

  DateTime get payDate => _payDate;
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
  Map<String, int> numbers = {
    "Daily": 1,
    "Weekly": 7,
    "Bi-Weekly": 14,
    "Semi-Monthly": 15,
    "Monthly": 30,
    "Quarterly": 90,
    "Semi-Annually": 180,
    "Annually": 365
  };

  FrequencyController() {
    _frequency =
        "Daily"; // 365(Daily), 52(Weekly), 26(Bi-Weekly), 24(Semi-Monthly), 12(Monthy), 4(Quarterly), 2(Semi-Annually), 1(Annually)
    _payDate = DateTime.now();
    ;
    _frequencyPreferences = FrequencyPreferences();
    _payDatePreferences = PayDatePreferences();
    getPreferences();
  }

  set payDate(DateTime value) {
    _payDate = value;
    _payDatePreferences.setDate(_payDate);
    notifyListeners();
  }

  //setting frequency's value which in turn changes payDates value.
  set frequency(String value) {
    _frequency = value;
    DateTime tempPayDate = DateTime.now().add(Duration(days: numbers[value]!));

    payDate = DateTime(tempPayDate.year, tempPayDate.month, tempPayDate.day);

    _frequencyPreferences.setFrequency(_frequency);
    notifyListeners();
  }

  getPreferences() async {
    _payDate = DateTime.parse(await _payDatePreferences.getDate());
    _frequency = await _frequencyPreferences.getFrequency();
    notifyListeners();
  }
}
