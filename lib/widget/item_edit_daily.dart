import 'package:flutter/material.dart';
import 'package:my_todo_app/model/daily_report.dart';

import '../source/string.dart';

class ItemEditDaily extends StatelessWidget {
  final Function(int, DailyReport) onEditItemDailyMoney;
  final Function(int) onDeleteItemDailyMoney;
  final DailyReport data;
  final int position;

  const ItemEditDaily(
      {super.key,
      required this.data,
      required this.position,
      required this.onEditItemDailyMoney,
      required this.onDeleteItemDailyMoney});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(data.amount)),
            Expanded(child: Text("${data.money}K")),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "edit",
                  child: Text(Strings.textEdit),
                ),
                const PopupMenuItem(
                  value: "delete",
                  child: Text(
                    Strings.textDelete,
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case "edit":
                    onEditItemDailyMoney(position, data);
                    break;
                  case "delete":
                    onDeleteItemDailyMoney(position);
                    break;
                }
              },
            )
          ],
        ),
        const Divider(height: 2, color: Colors.grey, endIndent: 16, indent: 16)
      ]),
    );
  }
}
