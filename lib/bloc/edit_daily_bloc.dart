import 'dart:async';

import '../model/daily_report.dart';
import '../model/day_report.dart';
import '../repository/daily_report_repository.dart';
import '../source/string.dart';

class EditDailyBloc {
  EditDailyBloc({required this.currentDayId});

  final _dailyRepository = DailyReportRepositoryImp.newInstance();
  final listItemController = StreamController<List<DailyReport>>();
  final saveChangeController = StreamController();
  final getDayController = StreamController<DayReport>();

  int currentDayId;

  List<DailyReport> _listDaily = <DailyReport>[];

  final _tempListDaily = <_DailyTypeReport>[];

  fetchDailyReport() async {
    _dailyRepository.getDayById(currentDayId).then((day) => getDayController.add(day));
    _dailyRepository.getAllDailyReports(currentDayId).then((listDailyResponse) {
      _listDaily = listDailyResponse;
      listItemController.add(_listDaily);
    }, onError: (error) {
      saveChangeController.addError(error);
    });
  }

  deleteDailyReport() async {
    await _dailyRepository.deleteDailyReport(currentDayId);
    saveChangeController.add(true);
  }

  deleteItemDaily(int position) {
    var dailyReport = _listDaily[position];
    _listDaily.removeAt(position);
    var tempDailyReport = _DailyTypeReport(_TypeReport.delete, dailyReport);
    _tempListDaily.add(tempDailyReport);
    listItemController.add(_listDaily);
  }

  editItemDaily(int position, String amount, String money) {
    if (_validateInput(amount, money)) {
      var dailyReport = _listDaily[position];
      dailyReport.money = int.parse(money);
      dailyReport.amount = amount;
      var tempDailyReport = _DailyTypeReport(_TypeReport.edit, dailyReport);
      _tempListDaily.add(tempDailyReport);
      listItemController.add(_listDaily);
    }
  }

  addItemDaily(String amount, String money) {
    if (_validateInput(amount, money)) {
      var newDailyReport = DailyReport.withoutId(amount, int.parse(money));
      _listDaily.add(newDailyReport);
      var tempDailyReport = _DailyTypeReport(_TypeReport.add, newDailyReport);
      _tempListDaily.add(tempDailyReport);
      listItemController.add(_listDaily);
    }
  }

  saveChangeDaily() async {
    if (hasChange()) {
      for (var task in _tempListDaily) {
        switch (task.typeReport) {
          case _TypeReport.add:
            await _executeAddItem(task.dailyReport);
            break;
          case _TypeReport.edit:
            await _executeEditItem(task.dailyReport);
            break;
          case _TypeReport.delete:
            await _executeDeleteItem(task.dailyReport);
            break;
        }
      }
      saveChangeController.add(true);
    }
  }

  bool hasChange() => _tempListDaily.isNotEmpty;

  bool _validateInput(String amount, String money) {
    if (amount.isEmpty) {
      saveChangeController.addError(Strings.textErrorEmptyAmount);
      return false;
    }
    if (money.isEmpty) {
      saveChangeController.addError(Strings.textErrorEmptyMoney);
      return false;
    }
    try {
      int.parse(money);
    } catch (e) {
      saveChangeController.addError(e.toString());
      return false;
    }
    return true;
  }

  _executeAddItem(DailyReport dailyReport) async {
    await _dailyRepository.insertDaily(currentDayId, dailyReport);
  }

  _executeEditItem(DailyReport dailyReport) async {
    await _dailyRepository.editDaily(dailyReport);
  }

  _executeDeleteItem(DailyReport dailyReport) async {
    await _dailyRepository.deleteDaily(dailyReport.id);
  }
}

class _DailyTypeReport {
  _TypeReport typeReport;
  DailyReport dailyReport;

  _DailyTypeReport(this.typeReport, this.dailyReport);
}

enum _TypeReport { add, edit, delete }
