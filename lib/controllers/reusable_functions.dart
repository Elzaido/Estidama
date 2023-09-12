import 'package:intl/intl.dart';

String getCurrentDate() {
  DateTime _currentDate = DateTime.now();
  DateFormat _dateFormatter = DateFormat.yMd();
  String getDateAsString = _dateFormatter.format(_currentDate);

  return getDateAsString;
}
