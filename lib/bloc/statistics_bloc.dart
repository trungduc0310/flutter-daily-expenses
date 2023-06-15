import 'dart:async';

import 'package:my_todo_app/source/string.dart';
import 'package:sprintf/sprintf.dart';

import '../entity/daily_reponse.dart';
import '../entity/statistics_reponse.dart';
import '../model/daily_report.dart';
import '../repository/daily_report_repository.dart';

class StatisticBloc {
  final _dailyRepository = DailyReportRepositoryImp.newInstance();

  final statisticController = StreamController<StatisticsResponse>();

  getStatisticRangeDay([int previousDay = 7]) async {
    var listDay = await _dailyRepository.getListRangeDaily(previousDay);
    if(listDay.isEmpty){
      statisticController.addError("Empty");
      return;
    }
    int countAmount = 0;
    int totalMoney = 0;
    for (var day in listDay) {
      countAmount += day.dailyReport?.length ?? 0;
      totalMoney += day.getTotalMoney();
    }
    DailyResponse dailyMaxMoney = listDay.reduce((day1, day2) =>
        day1.getAmountMaxMoney().money > day2.getAmountMaxMoney().money
            ? day1
            : day2);
    DailyReport maxAmount = dailyMaxMoney.getAmountMaxMoney();
    String textMaxAmount = sprintf(Strings.textValueMaxAmount,
        [maxAmount.amount, maxAmount.money, dailyMaxMoney.dayReport?.day]);
    int averageMoney = totalMoney ~/ previousDay;

    statisticController.add(StatisticsResponse(
        previousDay, countAmount, totalMoney, textMaxAmount, averageMoney));
  }
}
