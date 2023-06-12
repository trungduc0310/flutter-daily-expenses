import 'package:flutter/material.dart';
import 'package:my_todo_app/source/string.dart';

import '../bloc/add_daily_bloc.dart';
import '../entity/state_daily_add_item.dart';

class ItemAddDaily extends StatelessWidget {
  ItemAddDaily({super.key, required this.addDailyBloc, required this.item});

  final AddDailyBloc addDailyBloc;
  final ItemDailyStateAdd item;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _amountController.text = item.amount ?? "";
    if (item.money == null) {
      _moneyController.text = "";
    } else {
      _moneyController.text = item.money.toString();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: TextField(
                controller: _amountController,
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
                  controller: _moneyController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: Strings.textHintValueMoney),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done),
            ),
          ),
          Visibility(
            visible: item.visibleAdd,
            child: IconButton(
                onPressed: () {
                  addDailyBloc.addNewItemAddDaily();
                },
                icon: const Icon(
                  Icons.add_circle,
                  size: 36,
                  color: Colors.green,
                )),
          )
        ],
      ),
    );
  }
}
