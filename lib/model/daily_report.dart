import 'package:my_todo_app/data/db_provider.dart';

class DailyReport {
  int id = 0;
  String day;
  String amount;
  int money;

  DailyReport(this.id, this.day, this.amount, this.money);

  DailyReport.withoutId(this.day, this.amount, this.money);

  Map<String, dynamic> toMap() => {
        DbProvider.columnDay: day,
        DbProvider.columnAmount: amount,
        DbProvider.columnMoney: money
      };

  static DailyReport fromMap(Map<String, dynamic> mapResponse){
    var idResponse = mapResponse[DbProvider.columnId];
    var dayResponse = mapResponse[DbProvider.columnDay];
    var amountResponse = mapResponse[DbProvider.columnAmount];
    var moneyResponse = mapResponse[DbProvider.columnMoney];
    return DailyReport(idResponse, dayResponse, amountResponse, moneyResponse);
  }
}
