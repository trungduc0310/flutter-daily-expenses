import 'package:flutter/material.dart';

class CalendarUtils {
  static Future<void> showDatePickerCallback(
      BuildContext context, Function(DateTime) onSelectedDate, [DateTime? initDate]) async {
    var datePicked = await showDatePicker(
      context: context,
      initialDate: initDate ?? DateTime.now(),
      firstDate: DateTime.utc(1969),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    onSelectedDate.call(datePicked ?? DateTime.now());
  }
}
