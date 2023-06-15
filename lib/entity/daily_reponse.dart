import 'package:my_todo_app/model/daily_report.dart';
import 'package:my_todo_app/model/day_report.dart';

class DailyResponse {
  DayReport? dayReport;
  List<DailyReport>? dailyReport;

  DailyResponse([this.dayReport, this.dailyReport]);

  int getTotalMoney() {
    int total = 0;
    dailyReport?.forEach((daily) {
      total += daily.money;
    });
    return total;
  }

  DailyReport getAmountMaxMoney() {
    return dailyReport!.reduce(
        (daily1, daily2) => daily1.money > daily2.money ? daily1 : daily2);
  }
}
