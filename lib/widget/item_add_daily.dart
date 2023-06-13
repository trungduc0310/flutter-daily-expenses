import 'package:flutter/material.dart';

import '../model/daily_report.dart';

class ItemAddDaily extends StatelessWidget {
  const ItemAddDaily({super.key, required this.position, required this.data, required this.onEditItem, required this.onDeleteItem});

  final Function(int) onEditItem;
  final Function(int) onDeleteItem;
  final int position;
  final DailyReport data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onEditItem(position);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Text(data.amount, style: const TextStyle(fontSize: 16)),),
              ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text("${data.money}K", style: const TextStyle(fontSize: 16)),
                )),
            IconButton(onPressed: (){
              onDeleteItem(position);
            }, icon: const Icon(Icons.remove_circle, color: Colors.redAccent,))
          ],
        ),
      ),
    );
  }
}
