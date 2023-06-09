import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_todo_app/bloc/home_bloc.dart';
import 'package:my_todo_app/source/string.dart';
import 'package:my_todo_app/widget/item_daily_home.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final _bloc = HomeBloc();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: const Text(Strings.menuItemStatistics),
                      onTap: () {
                        //TODO: Navigate Thống kê
                      },
                    ),
                    PopupMenuItem(
                      child: const Text(Strings.menuItemClear),
                      onTap: () {
                        //TODO: Navigate Dọn dẹp
                      },
                    ),
                    PopupMenuItem(
                      child: const Text(Strings.menuItemAdvanceMoney),
                      onTap: () {
                        //TODO: Navigate Ứng tiền hàng ngày
                      },
                    ),
                  ])
        ],
      ),
      body: Center(
        child: ListView.builder(itemBuilder: (BuildContext context, int index){
          return ItemDailyHome(onEditItem: _onItemEdit);
        },itemCount: 10,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Strings.screenAdd).then((value){
          });
        },
        child: const Icon(Icons.add)
      ),
    );
  }

  void _onItemEdit(){
    Navigator.pushNamed(context, Strings.screenEdit).then((value) {
      print("edit sc back to homepage $value");
    });
  }
}


