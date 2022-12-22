import 'dart:ffi';
import 'package:string_ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../providers/wod_plan_provider.dart';

class _BarChart extends ConsumerWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muscleGroupBySetCount = ref.watch(muscleGroupBySetCountProvider);
    return muscleGroupBySetCount.when(
      error: (err, stack) => Text('Error: $err'),
      loading: () => const CircularProgressIndicator(),
      data: (muscleGroupBySetCountData) {
        return Container(
          margin: const EdgeInsets.only(top: 40, right: 5),
          child: BarChart(
            BarChartData(
              barTouchData: barTouchData,
              titlesData: titlesData(muscleGroupBySetCountData.keys.toList()),
              borderData: borderData,
              barGroups: getBarGroups(muscleGroupBySetCountData),
              gridData: FlGridData(show: true),
              alignment: BarChartAlignment.spaceAround,
              maxY: 30,
            ),
          ),
        );
      },
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 5,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta, List muscles) {
    const style = TextStyle(
      color: Colors.white,
      fontSize: 9,
    );
    String text = getXLabel(muscles[value.toInt()]);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  String getXLabel(String muscleName) {
    // Split the text with two word or more. This helps to display correctly
    // the xLabels in the bottom of the bars.
    // TODO CONVERT THIS SPLIT FUNCTION TO A MAP TO SELECT THE NAME
    List<String> muscleSplitName = muscleName.split(' ');
    return muscleSplitName[0].firstToUpper();
  }

  FlTitlesData titlesData(List muscles) => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (double value, TitleMeta meta) =>
                getTitles(value, meta, muscles),
          ),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: const Text('Sets',
              style: TextStyle(
                color: Colors.white,
              )),
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitlesWidget,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  SideTitleWidget getTitlesWidget(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.white, fontSize: 10);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 1,
      child: Text(
        '${value.toInt()}',
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.lightBlueAccent,
          Colors.greenAccent,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> getBarGroups(
      Map<String, Object?> muscleGroupBySetCount) {
    print('getBarGroup');
    print(muscleGroupBySetCount);
    // Check if the list is empty
    List<BarChartGroupData> muscleBarsGroup = [];
    int index = 0;
    if (muscleGroupBySetCount.isNotEmpty) {
      for (var muscle in muscleGroupBySetCount.keys) {
        final int tempObject = muscleGroupBySetCount[muscle] as int;
        final double muscleTotal = tempObject.toDouble();
        // final double muscleTotal = 5;
        BarChartGroupData muscleBar = BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              width: 15,
              borderRadius: const BorderRadius.all(
                Radius.circular(1),
              ),
              toY: muscleTotal,
              gradient: _barsGradient,
            )
          ],
          // This helps to display the number above the bar
          showingTooltipIndicators: [0],
        );
        muscleBarsGroup.add(muscleBar);
        index += 1;
      }
    }
    return muscleBarsGroup;
  }
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: const _BarChart(),
      ),
    );
  }
}
