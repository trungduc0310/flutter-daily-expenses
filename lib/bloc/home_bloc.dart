import 'dart:async';

import 'package:my_todo_app/model/daily_report.dart';
import 'package:my_todo_app/repository/daily_report_repository.dart';

class HomeBloc {
  final _dailyRepository = DailyReportRepositoryImp.newInstance();

  final dailyController = StreamController<List<DailyReport>>();

  fetchAllDaily() async {
    List<DailyReport> listDaily = await _dailyRepository.getAllDailyReports();
    dailyController.add(listDaily);
  }
}
