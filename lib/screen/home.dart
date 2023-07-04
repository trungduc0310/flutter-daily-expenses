import 'package:flutter/material.dart';
import 'package:my_todo_app/bloc/home_bloc.dart';
import 'package:my_todo_app/source/string.dart';
import 'package:my_todo_app/widget/item_daily_home.dart';

import 'edit_daily_note.dart';

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
    widget._bloc.fetchAllDaily();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value){
              Navigator.pushNamed(context, value);
            },
              itemBuilder: (BuildContext context) =>
              [
                const PopupMenuItem(
                  value: Strings.screenStatistics,
                  child: Text(Strings.menuItemStatistics),
                ),
                PopupMenuItem(
                  child: const Text(Strings.menuItemClear),
                  onTap: () {
                    //TODO: Navigate Dọn dẹp
                  },
                ),
                const PopupMenuItem(
                  value: Strings.screenAdvanceMoney,
                  child: Text(Strings.menuItemAdvanceMoney),
                ),
              ])
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: widget._bloc.dailyController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Error");
            }
            if (snapshot.hasData && snapshot.data != null) {
              if (snapshot.data!.isNotEmpty) {
                var listDataResponse = snapshot.data!;
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    var dataResponse = listDataResponse[index];
                    return ItemDailyHome(onEditItem: _onItemEdit, dailyResponse: dataResponse,);
                  },
                  itemCount: snapshot.data!.length,
                );
              }else{
                return const Text("Empty");
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Strings.screenAdd).then((value) {
              if(value == "reload"){
                widget._bloc.fetchAllDaily();
              }
            });
          },
          child: const Icon(Icons.add)),
    );
  }

  void _onItemEdit(int idDay) {
    Navigator.pushNamed(context, Strings.screenEdit,
            arguments: EditDailyArgument(idDay))
        .then((value) {
      widget._bloc.fetchAllDaily();
    });
  }
}
