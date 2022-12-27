import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/movement_history_provider.dart';
import '../../../../providers/pie_chart_provider.dart';
import 'legends_pie_chart.dart';

Map<String, Color> palletColors = {
  'beginner': Colors.grey,
  'intermediate': Colors.black26,
  'advanced': Colors.black54,
  'elit': Colors.black,
};

class PieChartDifficulty extends ConsumerStatefulWidget {
  const PieChartDifficulty({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PieChartDifficultyState();
}

class _PieChartDifficultyState extends ConsumerState<PieChartDifficulty> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final difficultyCount = ref.watch(difficultyCountProvider);
    return difficultyCount.when(
      error: (error, stackTrace) => Text('Error $error'),
      loading: () => const CircularProgressIndicator(),
      data: (difficultyData) {
        return Column(
          children: [
            Container(
              // TODO CONFIG RESPONSIVE SIZE
              width: 180,
              height: 150,
              padding: const EdgeInsets.all(0),
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) =>
                        touchChangeSizeBtn(event, pieTouchResponse, ref),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 3,
                  centerSpaceRadius: 30,
                  // sections: getPieSections(difficultyData, ref),
                  sections: getPieSections(difficultyData, ref),
                ),
              ),
            ),
            SizedBox(
              width: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: getLegends(difficultyData['difficulties']),
              ),
            )
          ],
        );
      },
    );
  }

  List<LegendsChart> getLegends(List difficultyCounts) {
    // Return a Row of Legends labels of the Pie chart
    List<LegendsChart> legendsChartsList = [];
    int index = 0;
    for (Map difficulty in difficultyCounts) {
      legendsChartsList.add(LegendsChart(
        index: index,
        label: difficulty['name'],
        palletColors: palletColors,
      ));
      index++;
    }
    return legendsChartsList;
  }

  void touchChangeSizeBtn(FlTouchEvent event, pieTouchResponse, WidgetRef ref) {
    // this display the effect of growth in the Pie chart
    if (!event.isInterestedForInteractions ||
        pieTouchResponse == null ||
        pieTouchResponse.touchedSection == null) {
      ref.watch(pieChartControllerProvider).setStateIndexPieChart(-1, ref);
      return;
    }
    ref.watch(pieChartControllerProvider).setStateIndexPieChart(
        pieTouchResponse.touchedSection!.touchedSectionIndex, ref);
  }

  List<PieChartSectionData> getPieSections(Map difficultyData, WidgetRef ref) {
    // Return to display the pie chart
    List<PieChartSectionData> listPieSections = [];
    int index = 0;
    if (difficultyData['difficulties'].isEmpty) {
      return [
        // This will show it when the user don't have any WOD
        // Only display
        PieChartSectionData(
            value: 1,
            title: '0%',
            color: palletColors['beginner'],
            radius: 25,
            titleStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ))
      ];
    }
    for (var data in difficultyData['difficulties']) {
      final isTouched = index == ref.watch(pieChartIndexProvider);
      final fontSize = isTouched ? 20.0 : 10.0;
      final radius = isTouched ? 35.0 : 25.0;
      double value = data['difficulty_count'] / difficultyData['total'];
      listPieSections.add(
        PieChartSectionData(
            value: value,
            title: '${(value * 100).round()}%',
            color: palletColors[data['name']],
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            )),
      );
      index++;
    }
    return listPieSections;
  }
}
