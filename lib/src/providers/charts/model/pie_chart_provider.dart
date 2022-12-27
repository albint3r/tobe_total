import 'package:flutter_riverpod/flutter_riverpod.dart';

final pieChartIndexProvider = StateProvider.autoDispose<int>((ref) {
  // Manage the state of the pie chart, when the user click to grow up the chart
  return -1;
});
