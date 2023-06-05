import 'package:flutter/material.dart';
import 'package:my_todo_app/source/string.dart';

class ItemEditDaily extends StatelessWidget {
  const ItemEditDaily({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: Text("Khoan tien")),
          const Expanded(child: Text("So tien")),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                size: 36,
                color: Colors.blue,
              ))
        ],
      ),
    );
  }
}
