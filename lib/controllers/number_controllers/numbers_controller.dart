import 'rolling_total_preferences.dart';
import 'package:flutter/material.dart';
import 'daily_total_preferences.dart';
import 'max_preferences.dart';
import 'time_stamp_preferences.dart';

class NumbersController extends ChangeNotifier {
  late RollingTotalPreferences _rollingTotalPreferences;
  late MaxPreferences _maxPreferences;
  late TimeStampPreferences _timeStampPreferences;
  late DailyTotalPreferences _dailyTotalPreferences;

  late String _timeStamp;
  late double _maxDaily;
  late double _rollingTotal;
  late double _dailyTotal;

  String get timeStamp => _timeStamp;
  double get maxDaily => _maxDaily;
  double get rollingTotal => _rollingTotal;
  double get dailyTotal => _dailyTotal;

  NumbersController() {
    _maxDaily = 0.00;
    _rollingTotal = 0.00;
    _dailyTotal = 0.00;
    _timeStamp = DateTime.now().toString();

    _dailyTotalPreferences = DailyTotalPreferences();
    _timeStampPreferences = TimeStampPreferences();
    _rollingTotalPreferences = RollingTotalPreferences();
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
  set rollingTotal(double value) {
    int resets = compareTimeStamps(DateTime.now(), DateTime.parse(_timeStamp));
    if (resets > 0) {
      _rollingTotal += (_maxDaily * resets);
      timeStamp = DateTime.now().toString();
      resetDailyLimit();
    }
    _rollingTotal -= value;
    _rollingTotalPreferences.setTotal(_rollingTotal);
    notifyListeners();
  }

  set dailyTotal(double value) {
    _dailyTotal -= value;
    _dailyTotalPreferences.setTotal(_dailyTotal);
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

  resetRollingDailyLimit() {
    _rollingTotal = _maxDaily;
    _rollingTotalPreferences.setTotal(_maxDaily);
    notifyListeners();
  }

  resetDailyLimit() {
    _dailyTotal = _maxDaily;
    _dailyTotalPreferences.setTotal(_maxDaily);
    notifyListeners();
  }

  getPreferences() async {
    _maxDaily = await _maxPreferences.getMax();
    _dailyTotal = await _dailyTotalPreferences.getTotal();
    _rollingTotal = await _rollingTotalPreferences.getTotal();
    _timeStamp = await _timeStampPreferences.getTimeStamp();
    notifyListeners();
  }
}
