import 'package:flutter/material.dart';
import 'package:my_todo_app/widget/item_edit_daily.dart';

import '../source/string.dart';
import '../utils/calendar_utils.dart';
import '../widget/dialog_edit_item.dart';

class EditDailyNotePage extends StatefulWidget {
  const EditDailyNotePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EditDailyNoteState();
  }
}

class _EditDailyNoteState extends State<EditDailyNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: TextButton(
                    onPressed: () {
                      CalendarUtils.showDatePickerCallback(context,
                          (datePicked) {
                        //TODO get date selected
                      });
                    },
                    child: const Text("Ngày: dd/MM/yyyy"))),
            ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ItemEditDaily(
                    onItemDailyMoney: _onEditItemDailyMoney,
                  );
                },
                itemCount: 6,
                shrinkWrap: true,
                physics: const ScrollPhysics()),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              alignment: Alignment.center,
              child: const Text(
                Strings.textButtonSaveDaily,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onEditItemDailyMoney(String amount, String money) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return DialogEditItemMoneyWidget(
              contentMoney: amount,
              valueMoney: money,
              onSaveNewMoney: _onSaveNewDailyMoney,
            );
          });
        });
  }

  void _onSaveNewDailyMoney(String amount, String money) {}
}