import 'package:my_todo_app/model/daily_report.dart';

import '../data/daily_dao.dart';

abstract class DailyReportRepository {
  Future<List<DailyReport>> getAllDailyReports();
  Future<int> insertDailyReport(DailyReport report);
  Future<int> updateDailyReport(int idReport, DailyReport report);
  Future<int> deleteDailyReport(int idReport);
  Future<void> deleteAllDailyReport();
}

class DailyReportRepositoryImp extends DailyReportRepository {

  static DailyReportRepositoryImp? _instance;

  static DailyReportRepositoryImp newInstance(){
    _instance ??= DailyReportRepositoryImp._();
    return _instance!;
  }

  DailyReportRepositoryImp._();

  final DailyDao _dailyDao = DailyDao();

  @override
  Future<void> deleteAllDailyReport() {
    return _dailyDao.deleteAllReport();
  }

  @override
  Future<int> deleteDailyReport(int idReport) {
    return _dailyDao.deleteReport(idReport);
  }

  @override
  Future<List<DailyReport>> getAllDailyReports() async {
    var listDaily = await _dailyDao.queryAllRows();
    return List.generate(listDaily.length, (i) {
      return DailyReport.fromMap(listDaily[i]);
    });
  }

  @override
  Future<int> insertDailyReport(DailyReport report) {
    return _dailyDao.insertReport(report.toMap());
  }

  @override
  Future<int> updateDailyReport(int idReport, DailyReport report) {
    return _dailyDao.updateReport(idReport, report.toMap());
  }

}
