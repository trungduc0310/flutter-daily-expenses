import 'dart:async';

import 'package:my_todo_app/source/string.dart';
import 'package:my_todo_app/utils/calendar_utils.dart';
import 'package:sprintf/sprintf.dart';

import '../model/daily_report.dart';
import '../repository/daily_report_repository.dart';

class AddDailyBloc {
  final _dailyRepository = DailyReportRepositoryImp.newInstance();

  bool isAddItem = true;
  DateTime dateSelected = DateTime.now();
  int editItemSelected = -1;

  final listItemController = StreamController<List<DailyReport>>();
  final addItemController = StreamController<List<DailyReport>>();
  final saveItemController = StreamController();

  final _listItem = <DailyReport>[];

  Future<bool> addItemDaily(String amount, String money) async {
    if (_validateInput(amount, money)) {
      var report = DailyReport.withoutId(amount, int.parse(money));
      _listItem.add(report);
      listItemController.add(_listItem);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editItemDaily(String amount, String money) async {
    if (_validateInput(amount, money)) {
      var report = DailyReport.withoutId(amount, int.parse(money));
      _listItem[editItemSelected] = report;
      listItemController.add(_listItem);
      return true;
    } else {
      return false;
    }
  }

  deleteItemDaily(int position) async {
    _listItem.removeAt(position);
    listItemController.add(_listItem);
  }

  bool _validateInput(String amount, String money) {
    if (amount.isEmpty) {
      addItemController.addError(Strings.textErrorEmptyAmount);
      return false;
    }
    if (money.isEmpty) {
      addItemController.addError(Strings.textErrorEmptyMoney);
      return false;
    }
    try {
      int.parse(money);
    } catch (e) {
      addItemController.addError(e.toString());
      return false;
    }
    return true;
  }

  bool checkDataEmpty() => _listItem.isEmpty;

  int getCountItem() => _listItem.length;

  Future<DailyReport> getItemSelectedByPosition() async {
    return _listItem[editItemSelected];
  }

  addDailyReport() async {
    var day = CalendarUtils.formatSelectDate(dateSelected);
    var timestamp = dateSelected.millisecondsSinceEpoch.toDouble();
    await _dailyRepository.insertDailyReport(day, timestamp, _listItem).then(
        (value) {
      saveItemController.add(value);
    }, onError: (error) {
      saveItemController
          .addError(sprintf(Strings.textErrorDuplicateDay, [day]));
    });
  }
}
