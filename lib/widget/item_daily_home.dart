import 'package:flutter/material.dart';

import '../entity/daily_reponse.dart';
import '../model/daily_report.dart';

class ItemDailyHome extends StatelessWidget {
  final Function onEditItem;
  final DailyResponse dailyResponse;

  const ItemDailyHome(
      {super.key, required this.onEditItem, required this.dailyResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ngày: ${dailyResponse.dayReport?.day}",
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                      fontSize: 16),
                ),
                IconButton(
                    onPressed: () {
                      onEditItem();
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 24,
                    ))
              ],
            ),
          ),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ItemMoneyOnDay(dailyReport: dailyResponse.dailyReport![index],);
            },
            itemCount: dailyResponse.dailyReport?.length ?? 0,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
          ),
          const Divider(
            height: 2,
            color: Colors.blueGrey,
            indent: 24,
            endIndent: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tổng tiền",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text("${dailyResponse.getTotalMoney()}K",
                    style: const TextStyle(
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
  const ItemMoneyOnDay({super.key, required this.dailyReport});

  final DailyReport dailyReport;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(dailyReport.amount), Text("${dailyReport.money}K")],
      ),
    );
  }
}
