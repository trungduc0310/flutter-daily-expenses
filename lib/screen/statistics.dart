import 'package:flutter/material.dart';
import 'package:my_todo_app/source/string.dart';
import 'package:sprintf/sprintf.dart';

import '../bloc/statistics_bloc.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({super.key});

  final StatisticBloc _bloc = StatisticBloc();

  @override
  State<StatefulWidget> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final _selectedDay = <bool>[true, false, false, false];

  @override
  void initState() {
    super.initState();
    widget._bloc.getStatisticRangeDay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: ToggleButtons(
              selectedColor: Colors.white,
              fillColor: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
              constraints: const BoxConstraints(minHeight: 36.0),
              isSelected: _selectedDay,
              onPressed: (index) {
                viewStatistic(index);
                setState(() {
                  for (int i = 0; i < _selectedDay.length; i++) {
                    _selectedDay[i] = i == index;
                  }
                });
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(Strings.textOptionStatistics7days),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(Strings.textOptionStatistics30days),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(Strings.textOptionStatistics90days),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(Strings.textOptionStatistics180days),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade300, width: 1)),
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(8),
              child: StreamBuilder(
                stream: widget._bloc.statisticController.stream,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    var dataResponse = snapshot.requireData;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(sprintf(Strings.textTitleCountDayStatistics,[dataResponse.previousDay]), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                        TextContentStatistics(content: Strings.textContentOptionCountAmount,arg: [dataResponse.countAmount],),
                        TextContentStatistics(content: Strings.textContentOptionTotalMoney, arg: [dataResponse.totalMoney],),
                        TextContentStatistics(content: Strings.textContentOptionMaxMoney,arg: [dataResponse.maxMoneyOnRange],),
                        TextContentStatistics(content: Strings.textContentOptionAverageMoney,arg: [dataResponse.averageMoneyInDay],),
                      ],
                    );
                  }else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()));
                  }else{
                    return const CircularProgressIndicator();
                  }
                }
              ),
            ),
          )
        ],
      ),
    );
  }

  void viewStatistic(int index) {
    int dayPrevious= 0;
    switch(index){
      case 0:
        dayPrevious = 7;
        break;
      case 1:
        dayPrevious = 30;
        break;
      case 2:
        dayPrevious =90;
        break;
      case 3:
        dayPrevious = 180;
        break;
    }
    widget._bloc.getStatisticRangeDay(dayPrevious);
  }
}

class TextContentStatistics extends StatelessWidget {
  const TextContentStatistics({
    super.key,
    required this.content,
    this.arg
  });

  final String content;
  final dynamic arg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8,left: 8),
        child: Text(sprintf(content,arg), style: const TextStyle(fontStyle: FontStyle.italic,fontSize: 16),));
  }
}
