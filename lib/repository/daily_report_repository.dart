import 'package:my_todo_app/entity/daily_reponse.dart';
import 'package:my_todo_app/model/daily_report.dart';
import 'package:my_todo_app/model/day_report.dart';

import '../data/daily_dao.dart';

abstract class DailyReportRepository {
  Future<List<DailyResponse>> getListDaily();

  Future<List<DailyReport>> getAllDailyReports(int dayId);

  Future<int> insertDailyReport(String day, List<DailyReport> dailyReport);

  Future<void> deleteDailyReport(int idDay);

  Future<void> deleteAllDailyReport();
}

class DailyReportRepositoryImp extends DailyReportRepository {
  static DailyReportRepositoryImp? _instance;

  static DailyReportRepositoryImp newInstance() {
    _instance ??= DailyReportRepositoryImp._();
    return _instance!;
  }

  DailyReportRepositoryImp._();

  final DailyDao _dailyDao = DailyDao();

  @override
  Future<List<DailyResponse>> getListDaily() async {
    var listDailyResponse = <DailyResponse>[];
    var listDay = await _dailyDao.queryAllDay();
    var listDaily = List.generate(
        listDay.length, (index) => DayReport.fromMap(listDay[index]));
    for (var day in listDaily) {
      var dayReport = DailyResponse();
      dayReport.dayReport = day;
      var listDaily = await _dailyDao.queryAllDailyInDay(day.id);
      dayReport.dailyReport = List.generate(
          listDaily.length, (index) => DailyReport.fromMap(listDaily[index]));
      listDailyResponse.add(dayReport);
    }
    return listDailyResponse;
  }

  @override
  Future<void> deleteAllDailyReport() async {
    await _dailyDao.deleteAllDaily();
    await _dailyDao.deleteAllDay();
  }

  @override
  Future<void> deleteDailyReport(int idDay) async {
    await _dailyDao.deleteDaily(idDay);
    await _dailyDao.deleteDay(idDay);
  }

  @override
  Future<int> insertDailyReport(String day, List<DailyReport> dailyReport) async {
    var idDay = await _dailyDao.insertDay(DayReport.withoutId(day).toMap());
    for (var daily in dailyReport) {
      daily.dayId = idDay;
      await _dailyDao.insertDaily(daily.toMap());
    }
    return idDay;
  }

  @override
  Future<List<DailyReport>> getAllDailyReports(int dayId) async {
    var listDaily = await _dailyDao.queryAllDailyInDay(dayId);
    return List.generate(listDaily.length, (index) => DailyReport.fromMap(listDaily[index]));
  }
}
