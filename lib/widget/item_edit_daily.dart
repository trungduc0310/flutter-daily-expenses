import 'package:flutter/material.dart';

class ItemEditDaily extends StatelessWidget {
  final Function(String, String) onItemDailyMoney;

  const ItemEditDaily({super.key, required this.onItemDailyMoney});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(child: Text("Mua do an sang")),
            const Expanded(child: Text("20k")),
            IconButton(
                onPressed: () {
                  onItemDailyMoney("Mua do an sang", "20K");
                },
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.blue,
                ))
          ],
        ),
        const Divider(height: 2, color: Colors.grey, endIndent: 16, indent: 16)
      ]),
    );
  }
}
