import 'package:string_ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../providers/is_dark_mode_provider.dart';
import '../../../../providers/wod_plan_provider.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';

class _BarChartWOD extends ConsumerWidget {
  const _BarChartWOD();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muscleGroupBySetCount = ref.watch(muscleGroupBySetCountProvider);
    return muscleGroupBySetCount.when(
      error: (err, stack) => Text('Error: $err'),
      loading: () => const CircularProgressIndicator(),
      data: (muscleGroupBySetCountData) {
        return BarChart(
          BarChartData(
            barTouchData: barTouchData(ref),
            titlesData: titlesData(
              muscleGroupBySetCountData.keys.toList(),
              ref,
            ),
            borderData: borderData,
            barGroups: getBarGroups(muscleGroupBySetCountData),
            gridData: FlGridData(show: true),
            alignment: BarChartAlignment.spaceAround,
            maxY: 30,
          ),
        );
      },
    );
  }

  BarTouchData barTouchData(WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProviderNotifier);
    return BarTouchData(
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
            TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta, List muscles, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProviderNotifier);
    final TextStyle style = TextStyle(
      color: isDark ? Colors.white : Colors.black,
      fontSize: 9,
    );
    // This create the xLabel formatted
    String text = getXLabelSingleWord(muscles[value.toInt()]);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  String getXLabelSingleWord(String muscleName) {
    // Split the text with two word or more. This helps to display correctly
    // the xLabels in the bottom of the bars.
    // TODO CONVERT THIS SPLIT FUNCTION TO A MAP TO SELECT THE NAME
    List<String> muscleSplitName = muscleName.split(' ');
    return muscleSplitName[0].firstToUpper();
  }

  FlTitlesData titlesData(List muscles, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProviderNotifier);
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (double value, TitleMeta meta) =>
              getTitles(value, meta, muscles, ref),
        ),
      ),
      leftTitles: AxisTitles(
        axisNameWidget: Text('Sets',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
            )),
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (double value, TitleMeta meta) =>
              getTitlesWidget(value, meta, ref),
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  SideTitleWidget getTitlesWidget(double value, TitleMeta meta, WidgetRef ref) {
    final isDark = ref.watch(isDarkModeProviderNotifier);
    final TextStyle style = TextStyle(
      color: isDark ? Colors.white : Colors.black,
      fontSize: 10,
    );
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
          Color.fromRGBO(255, 255, 255, 1.0),
          Color.fromRGBO(255, 0, 0, 1.0)
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

class BarChartMuscleSetCounter extends StatefulWidget {
  const BarChartMuscleSetCounter({super.key});

  @override
  State<StatefulWidget> createState() => BarChartMuscleSetCounterState();
}

class BarChartMuscleSetCounterState extends State<BarChartMuscleSetCounter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.05,
      child: AspectRatio(
        aspectRatio: 1.7,
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              // TODO THIS COULD BE A SINGLE WIDGET TO HOLD THE HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  H3FormFieldsHeader(
                    header: 'Total Sets by Muscle',
                  ),
                ],
              ),
              Container(
                height: 155,
                // THis create a Margin inside the card
                margin: const EdgeInsets.only(top: 20, right: 5),
                // The Bar Chart Object
                child: const _BarChartWOD(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
