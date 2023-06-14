import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/source/string.dart';

class CalendarUtils {
  static Future<void> showDatePickerCallback(
      BuildContext context, Function(DateTime) onSelectedDate,
    {DateTime? initDate}) async {
    var datePicked = await showDatePicker(
      context: context,
      initialDate: initDate ?? DateTime.now(),
      firstDate: DateTime.utc(1969),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    onSelectedDate.call(datePicked ?? DateTime.now());
  }

  static String formatSelectDate(DateTime date) {
    return DateFormat(Strings.patternFormatDate).format(date);
  }

  static double getTimestampBefore(int numberOfDay){
    var now = DateTime.now();
    var expectTime = DateTime(now.year, now.month, now.day - numberOfDay);
    return expectTime.millisecondsSinceEpoch.toDouble();
  }
}
