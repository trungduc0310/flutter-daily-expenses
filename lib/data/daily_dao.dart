import 'package:my_todo_app/data/db_provider.dart';

class DailyDao {
  final dailyProvider = DbProvider.dbProvider;

  Future<List<Map<String, dynamic>>> queryAllDay([int? dayId]) async {
    final dailyDb = await dailyProvider.database;
    if (dayId == null) {
      return dailyDb.query(DbProvider.tableDay,
          orderBy: '${DbProvider.columnTimestamp} desc');
    } else {
      return dailyDb.query(DbProvider.tableDay,
          where: '${DbProvider.columnDayId} = ?',
          whereArgs: [dayId],
          orderBy: '${DbProvider.columnTimestamp} desc');
    }
  }

  Future<int> insertDay(Map<String, dynamic> values) async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.insert(DbProvider.tableDay, values);
  }

  Future<int> updateDay(int id, Map<String, dynamic> values) async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.update(DbProvider.tableDay, values,
        where: '${DbProvider.columnDayId} = ?', whereArgs: [id]);
  }

  Future<int> deleteDay(int id) async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.delete(DbProvider.tableDay,
        where: '${DbProvider.columnDayId} = ?', whereArgs: [id]);
  }

  Future<void> deleteAllDay() async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.execute('DELETE FROM ${DbProvider.tableDay}');
  }

  Future<List<Map<String, dynamic>>> queryAllDailyInDay(int idDay) async {
    final dailyDb = await dailyProvider.database;
    return dailyDb.query(DbProvider.tableDaily,
        where: '${DbProvider.columnIdDay} = ?', whereArgs: [idDay]);
  }

  Future<int> insertDaily(Map<String, dynamic> values) async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.insert(DbProvider.tableDaily, values);
  }

  Future<int> updateDaily(int id, Map<String, dynamic> values) async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.update(DbProvider.tableDaily, values,
        where: '${DbProvider.columnDailyId} = ?', whereArgs: [id]);
  }

  Future<int> deleteDaily(int id) async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.delete(DbProvider.tableDaily,
        where: '${DbProvider.columnDailyId} = ?', whereArgs: [id]);
  }

  Future<void> deleteAllDaily() async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.execute('DELETE FROM ${DbProvider.tableDaily}');
  }
}
