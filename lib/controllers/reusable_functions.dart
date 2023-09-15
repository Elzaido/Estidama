import 'package:intl/intl.dart';

String getCurrentDate() {
  DateTime currentDate = DateTime.now();
  DateFormat dateFormatter = DateFormat.yMd();
  String getDateAsString = dateFormatter.format(currentDate);

  return getDateAsString;
}
