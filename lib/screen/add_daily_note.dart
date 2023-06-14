import 'package:flutter/material.dart';
import 'package:my_todo_app/source/string.dart';
import 'package:my_todo_app/utils/calendar_utils.dart';
import 'package:sprintf/sprintf.dart';

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
  final TextEditingController _textAmountController = TextEditingController();
  final TextEditingController _textMoneyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget._bloc.addItemController.stream.asBroadcastStream().listen((event) {},
        onError: (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    });
    widget._bloc.saveItemController.stream.asBroadcastStream().listen((event) {
      Navigator.pop(context, "reload");
    }, onError: (error){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    });
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
                      CalendarUtils.showDatePickerCallback(
                          context, _onDateSelected,
                          initDate: widget._bloc.dateSelected);
                    },
                    child: Text(
                        "${Strings.textTitleDay} ${CalendarUtils.formatSelectDate(widget._bloc.dateSelected)}"))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: TextField(
                        controller: _textAmountController,
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
                          controller: _textMoneyController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: Strings.textHintValueMoney),
                          onSubmitted: (value){
                            _onAddItemClick();
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done),
                    ),
                  ),
                  IconButton(
                      onPressed: _onAddItemClick,
                      icon: Icon(
                        widget._bloc.isAddItem
                            ? Icons.add_circle
                            : Icons.check_circle_sharp,
                        size: 36,
                        color:
                            widget._bloc.isAddItem ? Colors.green : Colors.blue,
                      ))
                ],
              ),
            ),
            StreamBuilder(
                stream: widget._bloc.listItemController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var listData = snapshot.requireData;
                    return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return ItemAddDaily(
                              position: index,
                              data: listData[index],
                              onEditItem: _onEditItemClick,
                              onDeleteItem: _onDeleteItemClick,);
                        },
                        itemCount: listData.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics());
                  } else {
                    return const Center();
                  }
                }),
            Container(
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                  onPressed: widget._bloc.checkDataEmpty()
                      ? null
                      : _onSaveDailyReportClick,
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

  void _onDateSelected(DateTime datePicked) {
    setState(() {
      widget._bloc.dateSelected = datePicked;
    });
  }

  void _onAddItemClick() async {
    FocusScope.of(context).unfocus();
    String amount = _textAmountController.text;
    String money = _textMoneyController.text;
    if (widget._bloc.isAddItem) {
      if (await widget._bloc.addItemDaily(amount, money)) {
        setState(() {
          _textAmountController.text = "";
          _textMoneyController.text = "";
          widget._bloc.isAddItem = true;
        });
      }
    } else {
      if (await widget._bloc.editItemDaily(amount, money)) {
        setState(() {
          _textAmountController.text = "";
          _textMoneyController.text = "";
          widget._bloc.isAddItem = true;
        });
      }
    }
  }

  void _onEditItemClick(int position) async {
    widget._bloc.editItemSelected = position;
    var itemSelect = await widget._bloc.getItemSelectedByPosition();
    setState(() {
      _textAmountController.text = itemSelect.amount;
      _textMoneyController.text = itemSelect.money.toString();
      widget._bloc.isAddItem = false;
    });
  }

  void _onDeleteItemClick(int position) async {
    await widget._bloc.deleteItemDaily(position);
    setState(() {});
  }

  void _onSaveDailyReportClick() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(Strings.textTitleConfirmSaveReport),
            content: Text(sprintf(Strings.textContentConfirmSaveReport, [
              CalendarUtils.formatSelectDate(widget._bloc.dateSelected),
              widget._bloc.getCountItem()
            ])),
            actions: [
              TextButton(
                  onPressed: () {Navigator.of(context).pop();}, child: const Text(Strings.textCancel)),
              TextButton(
                  onPressed: _onSaveDailyReport, child: const Text(Strings.textAccept)),
            ],
          );
        });
  }

  void _onSaveDailyReport() async {
    Navigator.of(context).pop();
    await widget._bloc.addDailyReport();
  }
}
