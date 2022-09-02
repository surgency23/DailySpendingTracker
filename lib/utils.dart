compareTimeStamps(DateTime currentTimeStamp, DateTime lastTimeStamp) {
  //round both last timestamp and current time stamp to midnight of that date and find the difference between the two.
  lastTimeStamp =
      DateTime(lastTimeStamp.year, lastTimeStamp.month, lastTimeStamp.day);
  currentTimeStamp = DateTime(
      currentTimeStamp.year, currentTimeStamp.month, currentTimeStamp.day);

  return currentTimeStamp.difference(lastTimeStamp).inDays;
}
