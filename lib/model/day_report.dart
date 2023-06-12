import '../data/db_provider.dart';

class DayReport {
  int id = 0;
  String day;

  DayReport(this.id, this.day);

  DayReport.withoutId(this.day);

  Map<String, dynamic> toMap() => {
    DbProvider.columnDay: day,
  };

  static DayReport fromMap(Map<String, dynamic> mapResponse){
    var id = mapResponse[DbProvider.columnDayId];
    var day = mapResponse[DbProvider.columnDay];
    return DayReport(id, day);
  }
}
