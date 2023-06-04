import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/source/string.dart';
import 'package:my_todo_app/utils/calendar_utils.dart';

import '../widget/item_add_daily.dart';

class AddDailyNotePage extends StatefulWidget {
  const AddDailyNotePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddDailyNotePageState();
  }
}

class _AddDailyNotePageState extends State<AddDailyNotePage> {

  @override
  void initState() {
    super.initState();
  }

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
                  return const ItemAddDaily();
                },
                itemCount: 1,
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
}
