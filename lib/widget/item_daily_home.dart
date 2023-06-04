import 'package:flutter/material.dart';

class ItemDailyHome extends StatelessWidget {
  const ItemDailyHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ngày: dd/MM/yyyy",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.black, fontSize: 16),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit,size: 24,))
              ],
            ),
          ),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return const ItemMoneyOnDay();
            },
            itemCount: 5,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
          ),
          const Divider(height: 2, color: Colors.blueGrey, indent: 24, endIndent: 24,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Tổng tiền",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text("Tổng số tiền K",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ItemMoneyOnDay extends StatelessWidget {
  const ItemMoneyOnDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Khoản tiền"), Text("Số tiền K")],
      ),
    );
  }
}
