import 'package:my_todo_app/data/db_provider.dart';

class DailyReport {
  int id = 0;
  int dayId = 0;
  String amount;
  int money;

  DailyReport(this.id, this.dayId, this.amount, this.money);

  DailyReport.withoutId(this.amount, this.money);

  Map<String, dynamic> toMap() => {
        DbProvider.columnIdDay: dayId,
        DbProvider.columnAmount: amount,
        DbProvider.columnMoney: money
      };

  static DailyReport fromMap(Map<String, dynamic> mapResponse){
    var idResponse = mapResponse[DbProvider.columnDailyId];
    var dayResponse = mapResponse[DbProvider.columnIdDay];
    var amountResponse = mapResponse[DbProvider.columnAmount];
    var moneyResponse = mapResponse[DbProvider.columnMoney];
    return DailyReport(idResponse, dayResponse, amountResponse, moneyResponse);
  }
}
