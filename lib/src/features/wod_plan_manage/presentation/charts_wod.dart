import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartsWOD extends ConsumerWidget {
  const ChartsWOD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: const [
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            // child: BarChartWOD(),
          ),
        )
      ],
    );
  }
}

class BarChartWOD extends StatelessWidget {
  const BarChartWOD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        maxY: 20,
        minY: -20,
        backgroundColor: Colors.blue,
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }

LinearGradient get _barsGradient => const LinearGradient(
  colors: [
    Colors.lightBlueAccent,
    Colors.greenAccent,
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

List<BarChartGroupData> get barGroups => [
  BarChartGroupData(
    x: 0,
    barRods: [
      BarChartRodData(
        toY: 8,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 1,
    barRods: [
      BarChartRodData(
        toY: 10,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 2,
    barRods: [
      BarChartRodData(
        toY: 14,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 3,
    barRods: [
      BarChartRodData(
        toY: 15,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 4,
    barRods: [
      BarChartRodData(
        toY: 13,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 5,
    barRods: [
      BarChartRodData(
        toY: 10,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 6,
    barRods: [
      BarChartRodData(
        toY: 16,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
];
}
