import 'package:flutter/material.dart';
import 'package:my_todo_app/widget/item_edit_daily.dart';
import 'package:sprintf/sprintf.dart';

import '../bloc/edit_daily_bloc.dart';
import '../model/daily_report.dart';
import '../source/string.dart';
import '../widget/dialog_edit_item.dart';

class EditDailyNotePage extends StatefulWidget {
  const EditDailyNotePage({super.key, required this.idDay});

  final int idDay;

  @override
  State<StatefulWidget> createState() {
    return _EditDailyNoteState();
  }
}

class _EditDailyNoteState extends State<EditDailyNotePage> {

  late EditDailyBloc _bloc;
  String _currentDateString = "";

  @override
  void initState() {
    super.initState();
    print("Edit arg idDay: ${widget.idDay}");
    _bloc = EditDailyBloc(currentDayId: widget.idDay);
    _bloc.saveChangeController.stream.listen((event) {
      Navigator.pop(context);
    }, onError: (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    });
    _bloc.fetchDailyReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _onDeleteDayClick, icon: const Icon(Icons.delete_outline,size: 30,))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: StreamBuilder(
              stream: _bloc.getDayController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var dayData = snapshot.requireData;
                  _currentDateString = dayData.day;
                  return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Ngày: $_currentDateString",
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ));
                } else {
                  return Container();
                }
              },
            )),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: _onAddDailyReport,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: const Text(
                      Strings.textButtonAddDailyReport,
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            StreamBuilder(
              stream: _bloc.listItemController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var listData = snapshot.requireData;
                  return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return ItemEditDaily(
                          data: listData[index],
                          position: index,
                          onEditItemDailyMoney: _onEditItemDailyMoney,
                          onDeleteItemDailyMoney: _onDeleteItemDailyMoney,
                        );
                      },
                      itemCount: listData.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics());
                } else {
                  return const Text("Empty");
                }
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                  onPressed: _bloc.hasChange() ? _onSaveChangeDaily : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: const Text(
                      Strings.textButtonSaveDaily,
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _onAddDailyReport(){
    showDialog(context: context, builder: (context){
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return
              DialogEditItemMoneyWidget(onSaveNewMoney: _onAddNewDailyMoney);
          });
    });
  }

  void _onEditItemDailyMoney(int position, DailyReport data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return DialogEditItemMoneyWidget(
              position: position,
              contentMoney: data.amount,
              valueMoney: data.money.toString(),
              onSaveNewMoney: _onSaveNewDailyMoney,
            );
          });
        });
  }

  _onAddNewDailyMoney(String amount, String money) async {
    await _bloc.addItemDaily(amount, money);
    setState(() {});
  }

  _onDeleteItemDailyMoney(int position) async {
    await _bloc.deleteItemDaily(position);
    setState(() {});
  }

  _onSaveNewDailyMoney(int position, String amount, String money) {
    _bloc.editItemDaily(position, amount, money);
    setState(() {});
  }

  _onDeleteDayClick(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text(Strings.textTitleConfirmDeleteReport),
        content: Text(sprintf(Strings.textContentConfirmDeleteReport, [_currentDateString,])),
        actions: [
          TextButton(
              onPressed: () {Navigator.of(context).pop();}, child: const Text(Strings.textCancel)),
          TextButton(
              onPressed: _onDeleteDailyReport, child: const Text(Strings.textAccept)),
        ],
      );
    });
  }

  _onDeleteDailyReport() async {
    Navigator.of(context).pop();
    await _bloc.deleteDailyReport();
  }

  _onSaveChangeDaily() async {
    await _bloc.saveChangeDaily();
  }
}

class EditDailyArgument {
  final int idDay;

  EditDailyArgument(this.idDay);
}
