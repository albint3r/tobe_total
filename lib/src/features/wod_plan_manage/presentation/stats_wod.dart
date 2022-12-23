import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common_widgets/stats_main_display/stats_main_display.dart';
import 'charts/bar_chart_wod.dart';
import 'charts/general_kpis.dart';

class ParentStatsWOD extends ConsumerWidget {
  // This class manage the order of the column of the element in the KPI section
  const ParentStatsWOD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MainDisplay(
      child: Column(
        children: const [
          GeneralKPIs(),
          BarChartMuscleSetCounter(),
        ],
      ),
    );
  }
}
