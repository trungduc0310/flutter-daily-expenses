import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static const _databaseName = "daily-money.db";
  static const _databaseVersion = 1;

  static const tableDay = 'day';

  static const columnDayId = 'id';
  static const columnDay = 'day';
  static const columnTimestamp = 'time_stamp';

  static const tableDaily = 'daily';

  static const columnDailyId = 'id';
  static const columnIdDay = 'id_day';
  static const columnAmount = 'amount';
  static const columnMoney = 'money';

  static final DbProvider dbProvider = DbProvider();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await init();
    return _db!;
  }

  init() async {
    final dbDir = await getDatabasesPath();
    final path = join(dbDir, _databaseName);
    var db = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tableDay("
        "$columnDayId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$columnDay TEXT,"
        "$columnTimestamp DOUBLE,"
        "UNIQUE ($columnDay))");

    await db.execute("CREATE TABLE $tableDaily("
        "$columnDailyId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$columnIdDay INTEGER, "
        "$columnAmount TEXT, "
        "$columnMoney INTEGER"
        ")");
  }
}