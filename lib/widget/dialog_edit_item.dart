import 'package:flutter/material.dart';

import '../source/string.dart';

class DialogEditItemMoneyWidget extends StatefulWidget {
  const DialogEditItemMoneyWidget(
      {super.key,
      this.position,
      this.contentMoney,
      this.valueMoney,
      required this.onSaveNewMoney});

  final int? position;
  final String? contentMoney;
  final String? valueMoney;
  final Function onSaveNewMoney;

  @override
  State<StatefulWidget> createState() => _StateDialogEditItemMoneyWidget();
}

class _StateDialogEditItemMoneyWidget extends State<DialogEditItemMoneyWidget> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();

  String _textErrorAmount = "";
  String _textErrorMoney = "";

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.contentMoney ?? "";
    _moneyController.text = widget.valueMoney ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextField(
              controller: _amountController,
              decoration: InputDecoration(
                  errorText:
                      _textErrorAmount.isNotEmpty ? _textErrorAmount : null,
                  border: const OutlineInputBorder(),
                  hintText: Strings.textHintContentMoney),
              textInputAction: TextInputAction.next,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextField(
              controller: _moneyController,
              decoration: InputDecoration(
                  errorText:
                      _textErrorMoney.isNotEmpty ? _textErrorMoney : null,
                  border: const OutlineInputBorder(),
                  hintText: Strings.textHintValueMoney),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _onSaveNewValue(context);
              },
              child: const Text(Strings.textButtonSaveEditDaily))
        ],
      ),
    );
  }

  _onSaveNewValue(BuildContext context) {
    if (_validateInput()) {
      var textAmount = _amountController.text;
      var textMoney = _moneyController.text;
      if (widget.position == null) {
        widget.onSaveNewMoney(textAmount, textMoney);
      } else {
        widget.onSaveNewMoney(widget.position, textAmount, textMoney);
      }
      Navigator.of(context).pop();
    }
  }

  bool _validateInput() {
    var textAmount = _amountController.text;
    var textMoney = _moneyController.text;
    if (textAmount.isEmpty) {
      setState(() {
        _textErrorAmount = Strings.textErrorEmptyAmount;
      });
      return false;
    }
    setState(() {
      _textErrorAmount = "";
    });
    if (textMoney.isEmpty) {
      setState(() {
        _textErrorMoney = Strings.textErrorEmptyMoney;
      });
      return false;
    }
    setState(() {
      _textErrorMoney = "";
    });
    try {
      int.parse(textMoney);
    } catch (e) {
      setState(() {
        _textErrorMoney = Strings.textErrorValidateMoney;
      });
      return false;
    }
    setState(() {
      _textErrorMoney = "";
      _textErrorAmount = "";
    });
    return true;
  }
}
