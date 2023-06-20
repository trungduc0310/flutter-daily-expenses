import 'package:flutter/material.dart';
import 'package:my_todo_app/source/string.dart';
import 'package:sprintf/sprintf.dart';

import '../bloc/statistics_bloc.dart';
import '../widget/item_daily_home.dart';

class DetailStatisticsPage extends StatefulWidget {
  DetailStatisticsPage({super.key, required this.dayPrevious});

  final int dayPrevious;
  final StatisticBloc _bloc = StatisticBloc();

  @override
  State<StatefulWidget> createState() => _DetailStatisticsState();
}

class _DetailStatisticsState extends State<DetailStatisticsPage> {
  @override
  void initState() {
    super.initState();
    widget._bloc.getStatisticRangeDay(previousDay: widget.dayPrevious);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            sprintf(Strings.textTitleCountDayStatistics, [widget.dayPrevious])),
      ),
      body: Center(
        child: StreamBuilder(
          stream: widget._bloc.statisticController.stream,
            builder: (context, snapshot) {
            if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            if(snapshot.hasData){
              var dataResponse = snapshot.requireData;
              return ListView.builder(itemBuilder: (context, index){
                return ItemDailyHome(onEditItem: (idDay){}, dailyResponse: dataResponse.listDays[index],);
              },
              itemCount: snapshot.requireData.listDays.length,);
            }
            return const CircularProgressIndicator();
            }),
      ),
    );
  }
}

class DetailStatisticsArgument {
  final int dayPrevious;

  DetailStatisticsArgument(this.dayPrevious);
}
