import '../data/db_provider.dart';

class DayReport {
  int id = 0;
  String day;
  double timestamp = 0;

  DayReport(this.id, this.day, this.timestamp);

  DayReport.withoutId(this.day, this.timestamp);

  Map<String, dynamic> toMap() => {
        DbProvider.columnDay: day,
        DbProvider.columnTimestamp: timestamp
      };

  static DayReport fromMap(Map<String, dynamic> mapResponse) {
    var id = mapResponse[DbProvider.columnDayId];
    var day = mapResponse[DbProvider.columnDay];
    var timestamp = mapResponse[DbProvider.columnTimestamp];
    return DayReport(id, day, timestamp);
  }
}
