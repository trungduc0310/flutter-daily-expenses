import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_todo_app/source/string.dart';

class AddAdvanceMoneyPage extends ConsumerWidget {
  const AddAdvanceMoneyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TextButton(
                    onPressed: () {}, child: const Text("dd/MM/yyyy")),
              ),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Text label"),
                  )),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Text label"),
                ),
              ),
              GroupOptionSplitMoney(),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Text("Danh sách"),
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Strings.screenListMemberAdvance);
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.green,
                              size: 28,
                            ))
                      ]),
                      Text("1000k")
                    ],
                  )),
              ListView.builder(
                itemBuilder: (context, index) {
                  return ItemPeopleInMoney();
                },
                itemCount: 20,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
              onPressed: () {}, child: const Text("Text button")),
        )
      ]),
    );
  }
}

class GroupOptionSplitMoney extends StatelessWidget {
  String? _option = "option1";

  GroupOptionSplitMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RadioListTile(
              title: const Text("Option 1"),
              value: "option1",
              groupValue: _option,
              onChanged: (value) {
                _option = value;
              }),
        ),
        Expanded(
          child: RadioListTile(
              title: const Text("Option 2"),
              value: "option2",
              groupValue: _option,
              onChanged: (value) {
                _option = value;
              }),
        ),
      ],
    );
  }
}

class ItemPeopleInMoney extends StatelessWidget {
  const ItemPeopleInMoney({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Color(0xFF7BC043),
            label: "end action 1",
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Color(0xFF0392CF),
            label: "end action 2",
          )
        ]),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Test Item"), Text("20")]),
        ));
  }
}
