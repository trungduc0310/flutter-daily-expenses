import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo_app/source/string.dart';

class AdvanceMoneyPage extends ConsumerWidget {
  const AdvanceMoneyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(value: Strings.screenAddAdvanceMoney,child: Text("Add"),),
                const PopupMenuItem(child: Text("Synthesize")),
              ],
              onSelected: (value) {
                Navigator.pushNamed(context, value);
              },
            )
          ],
        ),
        body: Column(
          children: [
            const Text("Total amount"),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return const ItemPeopleAdvance();
                },
                itemCount: 10,
              ),
            )
          ],
        ));
  }
}

class ItemPeopleAdvance extends StatelessWidget {
  const ItemPeopleAdvance({
    super.key,
  });

  final int _countAmount = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Column(children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Text(
                  "Total money",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
                itemBuilder: (context, index) {
                  if (index == _countAmount) {
                    return const Center(child: Text("Và 2 khoản tiền"));
                  } else {
                    return const ItemMoneyShortCut();
                  }
                },
                itemCount: _countAmount + 1,
                shrinkWrap: true,
                physics: const ScrollPhysics())
          ]),
        ),
        onTap: () {
          Navigator.pushNamed(context, Strings.screenDetailAdvanceMoney);
        },
      ),
    );
  }
}

class ItemMoneyShortCut extends StatelessWidget {
  const ItemMoneyShortCut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Amount"), Text("200")],
      ),
    );
  }
}
