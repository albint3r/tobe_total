import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../providers/calendar_provider.dart';


class CalendarWeekProgression extends ConsumerWidget {
  const CalendarWeekProgression({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TableCalendar(
      rowHeight: 40,
      headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          leftChevronVisible: false,
          rightChevronVisible: false
      ),
      startingDayOfWeek: ref.watch(startingDayOfWeekProvider),
      calendarFormat: CalendarFormat.week,
      focusedDay: ref.watch(focusDayProvider),
      firstDay: DateTime.utc(2022, 1, 1),
      lastDay: DateTime.utc(2030, 1, 1),
    );
  }
}