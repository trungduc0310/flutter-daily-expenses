import 'package:flutter/material.dart';

import '../source/string.dart';
import '../utils/calendar_utils.dart';

class EditDailyNotePage extends StatefulWidget{
  const EditDailyNotePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EditDailyNoteState();
  }
}

class _EditDailyNoteState extends State<EditDailyNotePage>{
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
                  return Text(index.toString());
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