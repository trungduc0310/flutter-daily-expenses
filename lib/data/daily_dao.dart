import 'package:my_todo_app/data/db_provider.dart';

class DailyDao {
  final dailyProvider = DbProvider.dbProvider;

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final dailyDb = await dailyProvider.database;
    return dailyDb.query(DbProvider.tableDaily);
  }

  Future<int> insertReport(Map<String, dynamic> values) async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.insert(DbProvider.tableDaily, values);
  }

  Future<int> updateReport(int id, Map<String, dynamic> values) async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.update(DbProvider.tableDaily, values,
        where: '${DbProvider.columnId} = ?', whereArgs: [id]);
  }

  Future<int> deleteReport(int id) async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.delete(DbProvider.tableDaily,
        where: '${DbProvider.columnId} = ?', whereArgs: [id]);
  }

  Future<void> deleteAllReport() async {
    final dailyDb = await dailyProvider.database;
    return await dailyDb.execute('DELETE FROM ${DbProvider.tableDaily}');
  }

}
