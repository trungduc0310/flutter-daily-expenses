import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo_app/screen/add_advance_money.dart';
import 'package:my_todo_app/screen/add_daily_note.dart';
import 'package:my_todo_app/screen/advance_money.dart';
import 'package:my_todo_app/screen/detail_advance_money.dart';
import 'package:my_todo_app/screen/detail_statistics.dart';
import 'package:my_todo_app/screen/edit_daily_note.dart';
import 'package:my_todo_app/screen/home.dart';
import 'package:my_todo_app/screen/statistics.dart';
import 'package:my_todo_app/source/string.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      onGenerateRoute: (setting) {
        if (setting.name == Strings.screenEdit) {
          final args = setting.arguments as EditDailyArgument;
          return MaterialPageRoute(builder: (context) {
            return EditDailyNotePage(idDay: args.idDay);
          });
        }
        if (setting.name == Strings.screenDetailStatistics) {
          final args = setting.arguments as DetailStatisticsArgument;
          return MaterialPageRoute(builder: (context) {
            return DetailStatisticsPage(dayPrevious: args.dayPrevious);
          });
        }
        if (setting.name == Strings.screenDetailAdvanceMoney) {
          return MaterialPageRoute(builder: (context) {
            return const DetailAdvanceMoneyPage();
          });
        }
        return null;
      },
      routes: {
        Strings.screenHome: (context) => HomePage(),
        Strings.screenAdd: (context) => AddDailyNotePage(),
        Strings.screenStatistics: (context) => StatisticsPage(),
        Strings.screenAdvanceMoney: (context) => const AdvanceMoneyPage(),
        Strings.screenAddAdvanceMoney: (context) => const AddAdvanceMoneyPage(),
      },
    );
  }
}
