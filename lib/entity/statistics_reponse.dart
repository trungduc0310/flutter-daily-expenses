import 'package:sprintf/sprintf.dart';

import '../model/daily_report.dart';
import '../source/string.dart';
import 'daily_reponse.dart';

class StatisticsResponse {
  int previousDay;
  List<DailyResponse> listDays;

  StatisticsResponse(this.previousDay, this.listDays);

  bool isEmpty() => listDays.isEmpty;

  int getCountAmount() {
    int countAmount = 0;
    for (var day in listDays) {
      countAmount += day.dailyReport?.length ?? 0;
    }
    return countAmount;
  }

  int getTotalMoney() {
    int totalMoney = 0;
    for (var day in listDays) {
      totalMoney += day.getTotalMoney();
    }
    return totalMoney;
  }

  String getContentMaxMoney() {
    DailyResponse dailyMaxMoney = getDailyMaxAmount();
    DailyReport maxAmount = dailyMaxMoney.getAmountMaxMoney();
    String textMaxAmount = sprintf(Strings.textValueMaxAmount,
        [maxAmount.amount, maxAmount.money, dailyMaxMoney.dayReport?.day]);
    return textMaxAmount;
  }

  DailyResponse getDailyMaxAmount() {
    return listDays.reduce((day1, day2) =>
        day1.getAmountMaxMoney().money > day2.getAmountMaxMoney().money
            ? day1
            : day2);
  }

  DailyResponse getDailyMaxMoney() {
    return listDays.reduce((day1, day2) =>
    day1.getTotalMoney() > day2.getTotalMoney()
        ? day1
        : day2);
  }

  int getMaxMoney() => getDailyMaxMoney().getTotalMoney();

  int getAverageMoney() => getTotalMoney() ~/ previousDay;
}
