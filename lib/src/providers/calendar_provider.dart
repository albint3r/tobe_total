import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../data_base/model/wods.dart';

class CalendarController {
  void setStateCurrentSelectedDay(WidgetRef ref, DateTime selectedDay) {
    ref.watch(selectedDayProvider.notifier).state = selectedDay;
  }

  void setStateFocusDayProvider(WidgetRef ref, DateTime focusedDay) {
    ref.watch(focusDayProvider.notifier).state = focusedDay;
  }

  void changeCalendarFormat(WidgetRef ref, CalendarFormat format) {
    // Change the format of the Calendar.
    if (ref.watch(calendarFormatProvider) != format) {
      ref.watch(calendarFormatProvider.notifier).state = format;
    }
  }

  List getWODsFromDay(DateTime? day, var data) {
    // Return the WodsEvents
    return data[day] ?? [];
  }
}

final calendarControllerProvider = Provider<CalendarController>((ref) {
  return CalendarController();
});

final focusDayProvider = StateProvider.autoDispose<DateTime>((ref) {
  return DateTime.now();
});

final calendarFormatProvider = StateProvider.autoDispose<CalendarFormat>((ref) {
  return CalendarFormat.month;
});

final startingDayOfWeekProvider =
    StateProvider.autoDispose<StartingDayOfWeek>((ref) {
  return StartingDayOfWeek.monday;
});

final selectedDayProvider = StateProvider<DateTime?>((ref) {
  return null;
});

final wodsModelProvider = StateProvider<WODs>((ref) {
  return WODs();
});

final wodsAllTrainingsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final wods = ref.watch(wodsModelProvider);
  return await wods.getWODs();
});

final selectedEventsProvider = FutureProvider.autoDispose<Map<DateTime, List<dynamic>>>((ref) async {
  final response = await ref.watch(wodsModelProvider).getWODs();
  Map<DateTime, List<dynamic>> calendarWods = {};
  for (var r in response) {
    // TODO CHANGE THIS CREATE DATE FOR -> EXPECTED TRAINING DAY
    final date = DateFormat("yyyy-MM-dd").parse(r['expected_training_day'] as String);
    if (calendarWods[DateTime.utc(date.year, date.month, date.day)] == null) {
      calendarWods[DateTime.utc(date.year, date.month, date.day)] = [r];
    } else {
      calendarWods[DateTime.utc(date.year, date.month, date.day)]!.add(r);
    }
  }
  return calendarWods;
});
