import 'package:flutter_riverpod/flutter_riverpod.dart';

class PieChartIndexController {

  void setStateIndexPieChart(int value, WidgetRef ref) {
    ref.watch(pieChartIndexProvider.notifier).state = value;
  }

}

final pieChartIndexProvider = StateProvider.autoDispose<int>((ref) {
  // Manage the state of the pie chart, when the user click to grow up the chart
  return -1;
});

final pieChartControllerProvider = Provider<PieChartIndexController>((ref) {
  return PieChartIndexController();
});
