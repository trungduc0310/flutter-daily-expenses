import 'dart:async';

import '../entity/statistics_reponse.dart';
import '../repository/daily_report_repository.dart';

class StatisticBloc {
  final _dailyRepository = DailyReportRepositoryImp.newInstance();

  final statisticController = StreamController<StatisticsResponse>();

  int previousDay = 0;

  getStatisticRangeDay({int previousDay = 7, bool hasSort = false}) async {
    this.previousDay = previousDay;
    var listDay = await _dailyRepository
        .getListRangeDaily(previousDay, hasSort)
        .then((response) => StatisticsResponse(previousDay, response));
    if (listDay.isEmpty()) {
      statisticController.addError("Empty");
      return;
    }
    statisticController.add(listDay);
  }
}
