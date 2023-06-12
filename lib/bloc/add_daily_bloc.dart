import 'dart:async';

import '../entity/state_daily_add_item.dart';
import '../repository/daily_report_repository.dart';

class AddDailyBloc {
  final _dailyRepository = DailyReportRepositoryImp.newInstance();
  final stateAddDaily = StreamController<List<ItemDailyStateAdd>>();

  final _listStateAddItem = <ItemDailyStateAdd>[];

  AddDailyBloc() {
    _listStateAddItem.add(ItemDailyStateAdd());
    stateAddDaily.add(_listStateAddItem);
  }

  addNewItemAddDaily() {
    _listStateAddItem.add(ItemDailyStateAdd());
    var lastItemIndex = _listStateAddItem.length - 2;
    _listStateAddItem[lastItemIndex].visibleAdd = false;
    stateAddDaily.add(_listStateAddItem);
  }
}
