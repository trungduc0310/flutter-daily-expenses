import 'package:flutter/material.dart';

import '../source/string.dart';

class DialogEditItemMoneyWidget extends StatelessWidget {

  const DialogEditItemMoneyWidget(
      {super.key,
      required this.contentMoney,
      required this.valueMoney,
      required this.onSaveNewMoney});

  final String contentMoney;
  final String valueMoney;
  final Function(String, String) onSaveNewMoney;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: Strings.textHintContentMoney),
              textInputAction: TextInputAction.next,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: Strings.textHintValueMoney),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
          ),
          ElevatedButton(
              onPressed: () {},
              child: const Text(Strings.textButtonSaveEditDaily))
        ],
      ),
    );
  }
}
