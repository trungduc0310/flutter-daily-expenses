import 'package:flutter/material.dart';
import 'package:my_todo_app/screen/add_daily_note.dart';
import 'package:my_todo_app/screen/home.dart';
import 'package:my_todo_app/source/string.dart';

void main() {
  runApp(const MyApp());
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
      home: const HomePage(),
      routes:{
        Strings.screenHome: (context) => const HomePage(),
        Strings.screenAdd: (context) => const AddDailyNotePage(),
      },
    );
  }
}
