import 'dart:async';

import 'package:my_todo_app/entity/daily_reponse.dart';
import 'package:my_todo_app/model/daily_report.dart';
import 'package:my_todo_app/repository/daily_report_repository.dart';

class HomeBloc {
  final _dailyRepository = DailyReportRepositoryImp.newInstance();

  final dailyController = StreamController<List<DailyResponse>>();

  fetchAllDaily() async {
    var dailyResponse = await _dailyRepository.getListDaily();
    dailyController.add(dailyResponse);
  }
}
