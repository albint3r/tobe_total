import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/movement_history_provider.dart';
import '../../../../providers/pie_chart_provider.dart';

Map palletColors = {
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
        return Container(
          // TODO CONFIG RESPONSIVE SIZE
          width: 180,
          height: 150,
          padding: const EdgeInsets.all(10),
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      ref
                          .watch(pieChartControllerProvider)
                          .setStateIndexPieChart(-1, ref);
                      return;
                    }
                    ref.watch(pieChartControllerProvider).setStateIndexPieChart(
                        pieTouchResponse.touchedSection!.touchedSectionIndex,
                        ref);
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 30,
                // sections: getPieSections(difficultyData, ref),
                sections: getPieSections(difficultyData, ref),
              ),
            ),
          ),
        );
      },
    );
  }

  List<PieChartSectionData> getPieSections(Map difficultyData, WidgetRef ref) {
    // Return to display the pie chart
    print('-----------------');
    print(difficultyData);
    List<PieChartSectionData> listPieSections = [];
    int index = 0;
    if (difficultyData['difficulties'].isEmpty) {
      return [
        PieChartSectionData(
            value: 1,
            title: '0%',
            color: palletColors['beginner'],
            radius: 30,
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
      final radius = isTouched ? 40.0 : 30.0;
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
