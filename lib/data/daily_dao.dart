import 'package:my_todo_app/data/db_provider.dart';

import '../model/daily_report.dart';

class DailyDao {
  final dailyProvider = DbProvider.dbProvider;

  Future<List<DailyReport>> queryAllRows() async {
    final dailyDb = await dailyProvider.database;
    final List<Map<String, dynamic>> listDaily =
        await dailyDb.query(DbProvider.tableDaily);
    return List.generate(listDaily.length, (i) {
      return DailyReport.fromMap(listDaily[i]);
    });
  }

  Future<int> insertQuote(Map<String, dynamic> values) async {
    final quoteDb = await dailyProvider.database;
    return await quoteDb.insert(DbProvider.tableDaily, values);
  }

  Future<int> updateQuote(int id, Map<String, dynamic> values) async {
    final quoteDb = await dailyProvider.database;
    return await quoteDb.update(DbProvider.tableDaily, values,
        where: '${DbProvider.columnId} = ?', whereArgs: [id]);
  }

  Future<int> deleteQuote(int id) async {
    final quoteDb = await dailyProvider.database;
    return await quoteDb.delete(DbProvider.tableDaily,
        where: '${DbProvider.columnId} = ?', whereArgs: [id]);
  }

  Future<void> deleteAllQuotes() async {
    final quoteDb = await dailyProvider.database;
    return await quoteDb.execute('DELETE FROM ${DbProvider.tableDaily}');
  }

}
