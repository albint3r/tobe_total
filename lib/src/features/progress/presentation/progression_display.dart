import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'block_trio_kpi.dart';
import 'body_heatmap_progression.dart';
import 'calendar/calendar_week_progress.dart';
import 'calendar/goal_bar_progression.dart';
import 'calendar/line_icon_complete_day_indicators.dart';
import 'charts/spiderweb_chart_progression.dart';

class ProgressionDisplay extends ConsumerWidget {
  const ProgressionDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return PieChartSample2();
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: const [
              CalendarWeekProgression(),
              LineCompleteDaysIndicators(),
              GoalBarProgression()
            ],
          ),
        ),
        Column(
          children: const [BlockTrioKPI()],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            BodyHeadMap(),
            PieChartDifficulty(),
          ],
        )
      ],
    );
  }
}
