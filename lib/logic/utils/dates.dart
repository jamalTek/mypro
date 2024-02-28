import 'package:intl/intl.dart';

Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
  var i = start;
  var offset = start.timeZoneOffset;
  while (i.day <= end.day) {
    yield i;
    i = i.add(const Duration(days: 1));
    final timeZoneDiff = i.timeZoneOffset - offset;
    if (timeZoneDiff.inSeconds != 0) {
      offset = i.timeZoneOffset;
      i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
    }
  }
}

DateTime mostRecentSunday(DateTime date) =>
    date.add(Duration(days: DateTime.daysPerWeek - date.weekday));

DateTime mostRecentMonday(DateTime date) =>
    date.subtract(Duration(days: date.weekday - 1));

DateTime firstDayOfWeek(DateTime day) {
  day = DateTime.utc(day.year, day.month, day.day);
  final toDelete = day.weekday;
  return day.subtract(Duration(days: toDelete));
}

DateTime lastDayOfWeek(DateTime day) {
  day = DateTime.utc(day.year, day.month, day.day);
  final toAdd = 7 - day.weekday;
  return day.add(Duration(days: toAdd));
}

String dayFormat(DateTime day) {
  return DateFormat('EEEE').format(day);
}

String timeFormat(DateTime day) {
  return DateFormat('hh:mm aa').format(day);
}

String timeFormat24(DateTime day) {
  return DateFormat('hh:mm').format(day);
}

String apiDayTimeFormate(DateTime day) {
  return DateFormat('yyyy-MM-dd hh:mm').format(day);
}

String apiDayFormate(DateTime day) {
  return DateFormat('yyyy-MM-dd').format(day);
}
