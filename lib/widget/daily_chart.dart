import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../entity/statistics_reponse.dart';

class LineChartDaily extends StatelessWidget {
  LineChartDaily({super.key, required this.daysCalChart});

  final double _marginTopMoney = 200;

  final StatisticsResponse daysCalChart;
  final List<Color> gradientColors = [
    Colors.lightBlueAccent,
    Colors.blueAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: LineChart(
            mainData(),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    try {
      var dayReport = daysCalChart.listDays[value.toInt()].dayReport?.getShortDay();
      String text = dayReport ?? "";
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(text, style: style),
      );
    } catch (e) {
      return Container();
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    try {
      if (value == daysCalChart.getMaxMoney().toDouble()) {
        String text = "${daysCalChart.getMaxMoney().toString()}K";
        return Text(text, style: style, textAlign: TextAlign.left);
      }
      if (value == daysCalChart.getMaxMoney().toDouble() + _marginTopMoney) {
        String text =
            "${(daysCalChart.getMaxMoney() + _marginTopMoney.toInt()).toString()}K";
        return Text(text, style: style, textAlign: TextAlign.left);
      }
      return Container();
    } catch (e) {
      return Container();
    }
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles:
          SideTitles(showTitles: true,
              interval: getIntervalDay(),
              getTitlesWidget: bottomTitleWidgets),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 2,
            reservedSize: 40,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      maxX: daysCalChart.previousDay.toDouble(),
      maxY: daysCalChart.getMaxMoney().toDouble() + _marginTopMoney,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: generateListSpot(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> generateListSpot() {
    var listSpots = <FlSpot>[];
    for (int x = 0; x < daysCalChart.listDays.length; x++) {
      listSpots.add(FlSpot(
          x.toDouble(), daysCalChart.listDays[x].getTotalMoney().toDouble()));
    }
    return listSpots;
  }

  double getIntervalDay() {
    switch(daysCalChart.previousDay){
      case 7:
        return 1;
      case 30:
        return 7;
      case 90:
        return 15;
      case 180:
        return 45;
      default:
        return 2;
    }
  }
}
