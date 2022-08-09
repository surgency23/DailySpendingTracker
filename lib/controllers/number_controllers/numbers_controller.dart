import 'package:flutter/material.dart';
import 'current_total_preferences.dart';
import 'daily_max_preferences.dart';
import 'time_stamp_preferences.dart';

class NumbersController extends ChangeNotifier {
  late CurrentTotalPreferences _totalPreferences;
  late MaxPreferences _maxPreferences;
  late TimeStampPreferences _timeStampPreferences;

  late String _timeStamp;
  late double _maxDaily;
  late double _currentTotal;

  String get timeStamp => _timeStamp;
  double get maxDaily => _maxDaily;
  double get currentTotal => _currentTotal;

  NumbersController() {
    _maxDaily = 0.00;
    _currentTotal = 0.00;
    _timeStamp = DateTime.now().toString();
    _timeStampPreferences = TimeStampPreferences();
    _totalPreferences = CurrentTotalPreferences();
    _maxPreferences = MaxPreferences();
    getPreferences();
  }

  //setting maxDaily's value
  set maxDaily(double value) {
    _maxDaily = value;
    _maxPreferences.setMax(value);
    notifyListeners();
  }

  //setting currentTotals's value
  set currentTotal(double value) {
    int resets = compareTimeStamps(DateTime.now(), DateTime.parse(_timeStamp));
    if (resets > 0) {
      _currentTotal += (_maxDaily * resets);
      timeStamp = DateTime.now().toString();
    }
    _currentTotal -= value;
    _totalPreferences.setTotal(_currentTotal);
    notifyListeners();
  }

  set timeStamp(String value) {
    _timeStamp = value;
    _timeStampPreferences.setTimeStamp(_timeStamp);
    notifyListeners();
  }

  compareTimeStamps(DateTime currentTimeStamp, DateTime lastTimeStamp) {
    //round both last timestamp and current time stamp to midnight of that date and find the difference between the two.
    lastTimeStamp =
        DateTime(lastTimeStamp.year, lastTimeStamp.month, lastTimeStamp.day);
    currentTimeStamp = DateTime(
        currentTimeStamp.year, currentTimeStamp.month, currentTimeStamp.day);

    return currentTimeStamp.difference(lastTimeStamp).inDays;
  }

  resetDailyLimit() {
    _currentTotal = _maxDaily;
    _totalPreferences.setTotal(_maxDaily);
    notifyListeners();
  }

  getPreferences() async {
    _maxDaily = await _maxPreferences.getMax();
    _currentTotal = await _totalPreferences.getTotal();
    _timeStamp = await _timeStampPreferences.getTimeStamp();
    notifyListeners();
  }
}
