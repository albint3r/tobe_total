import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../providers/training_week/model/calendar_provider.dart';
import '../../../../providers/theme/is_dark_mode_provider.dart';


class CalendarWeekProgression extends ConsumerWidget {
  // This class display the bar goal progression below the Calendar
  // in the progress screen.
  const CalendarWeekProgression({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProviderNotifier);
    return TableCalendar(
      rowHeight: 40,
      calendarStyle: CalendarStyle(
          markerDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode ? Colors.blueAccent : Colors.black,
          ),
          todayTextStyle: const TextStyle(color: Colors.white),
          todayDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          )),
      headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          leftChevronVisible: false,
          rightChevronVisible: false,
      ),
      startingDayOfWeek: ref.watch(startingDayOfWeekProvider),
      calendarFormat: CalendarFormat.week,
      focusedDay: ref.watch(focusDayProvider),
      firstDay: DateTime.utc(2022, 1, 1),
      lastDay: DateTime.utc(2030, 1, 1),
    );
  }
}