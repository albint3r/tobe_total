import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/pie_chart_provider.dart';


class PieChartIndexController {
  void setStateIndexPieChart(int value, WidgetRef ref) {
    ref.watch(pieChartIndexProvider.notifier).state = value;
  }
}

final pieChartControllerProvider = Provider<PieChartIndexController>((ref) {
  return PieChartIndexController();
});
