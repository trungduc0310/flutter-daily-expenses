import 'package:my_todo_app/model/daily_report.dart';
import 'package:my_todo_app/model/day_report.dart';

class DailyResponse {
  DayReport? dayReport;
  List<DailyReport>? dailyReport;

  DailyResponse([this.dayReport, this.dailyReport]);
}
