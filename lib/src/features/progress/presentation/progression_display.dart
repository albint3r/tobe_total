import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'calendar/calendar_week_progress.dart';
import 'calendar/goal_bar_progression.dart';
import 'calendar/line_icon_complete_day_indicators.dart';


class ProgressionDisplay extends ConsumerWidget {
  const ProgressionDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
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
          children: [
            Placeholder(
                fallbackHeight: 50,
                fallbackWidth: MediaQuery.of(context).size.height / 1.05)
          ],
        )
      ],
    );
  }
}


