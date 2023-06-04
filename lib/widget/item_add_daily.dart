import 'package:flutter/material.dart';
import 'package:my_todo_app/source/string.dart';

class ItemAddDaily extends StatelessWidget {
  const ItemAddDaily({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 6),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: Strings.textHintContentMoney),
                textInputAction: TextInputAction.next,
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 6),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: Strings.textHintValueMoney),
                keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done
              ),
            ),
          ),
          IconButton(onPressed: (){}, icon: const Icon(Icons.add_circle, size: 36, color: Colors.green,))
        ],
      ),
    );
  }
}


