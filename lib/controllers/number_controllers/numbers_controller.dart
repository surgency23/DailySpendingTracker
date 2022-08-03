import 'package:flutter/material.dart';
import 'current_total_preferences.dart';
import 'daily_max_preferences.dart';

class NumbersController extends ChangeNotifier {
  late CurrentTotalPreferences _totalPreferences;
  late MaxPreferences _maxpreferences;
  late double _maxDaily;
  late double _currentTotal;
  double get maxDaily => _maxDaily;
  double get currentTotal => _currentTotal;

  NumbersController() {
    _maxDaily = 0.00;
    _currentTotal = 0.00;
    _totalPreferences = CurrentTotalPreferences();
    _maxpreferences = MaxPreferences();
    getPreferences();
  }

//setting maxDaily's value
  set maxDaily(double value) {
    _maxDaily = value;
    _maxpreferences.setMax(value);
    notifyListeners();
  }

  //setting currentTotals's value
  set currentTotal(double value) {
    _currentTotal -= value;
    _totalPreferences.setTotal(value);
    notifyListeners();
  }

  getPreferences() async {
    _maxDaily = await _maxpreferences.getMax();
    _currentTotal = await _totalPreferences.getTotal();
    notifyListeners();
  }
}
