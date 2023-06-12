import 'package:flutter/material.dart';
import 'package:my_todo_app/source/string.dart';
import 'package:my_todo_app/utils/calendar_utils.dart';

import '../bloc/add_daily_bloc.dart';
import '../widget/item_add_daily.dart';

class AddDailyNotePage extends StatefulWidget {
  AddDailyNotePage({super.key});

  final _bloc = AddDailyBloc();

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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, "test");
            },
            icon: const Icon(Icons.arrow_back)),
      ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: Strings.textHintContentMoney),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: Strings.textHintValueMoney),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_circle,
                        size: 36,
                        color: Colors.green,
                      ))
                ],
              ),
            ),
            ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Text("Test");
                },
                itemCount: 100,
                shrinkWrap: true,
                physics: const ScrollPhysics()),
            Container(
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, "test");
                  },
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
}
