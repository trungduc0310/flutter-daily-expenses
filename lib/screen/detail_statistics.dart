import 'package:flutter/material.dart';
import 'package:my_todo_app/source/string.dart';
import 'package:sprintf/sprintf.dart';

import '../bloc/statistics_bloc.dart';

class DetailStatisticsPage extends StatefulWidget{

  DetailStatisticsPage({super.key, required this.dayPrevious});
  final int dayPrevious;
  final StatisticBloc _bloc = StatisticBloc();


  @override
  State<StatefulWidget> createState() => _DetailStatisticsState();

}

class _DetailStatisticsState extends State<DetailStatisticsPage>{

  @override
  Widget build(BuildContext context ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sprintf(Strings.textTitleCountDayStatistics, [widget.dayPrevious])),
      ),
      body: Container(),
    );
  }

}

class DetailStatisticsArgument {
  final int dayPrevious;

  DetailStatisticsArgument(this.dayPrevious);
}