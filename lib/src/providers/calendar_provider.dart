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

  void unselectDayCalendar(WidgetRef ref) {
    // Unselect the day Select in the calendar.
    // This will display another menu in the Card area.
    ref.watch(selectedDayProvider.notifier).state = null;
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
  // This is the current datetime in the calendar
  return DateTime.now();
});

final calendarFormatProvider = StateProvider<CalendarFormat>((ref) {
  // This is the current format of the Calendar
  return CalendarFormat.twoWeeks;
});

final startingDayOfWeekProvider =
    StateProvider.autoDispose<StartingDayOfWeek>((ref) {
      // This is the day start the calendar
  return StartingDayOfWeek.monday;
});

final selectedDayProvider = StateProvider<DateTime?>((ref) {
  // This hold the state of the selected Day in the calendar
  return null;
});

final wodsModelProvider = StateProvider<WODs>((ref) {
  // get the WOD Class
  return WODs();
});

final wodsAllTrainingsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  // Return a list of all the wods. This is when the user
  // hasn't select any day on the calendar. So this will display all the
  // Wods to train.
  // TODO THIS COULD CHANGE: to only show the last 7 trainings created.
  final wods = ref.watch(wodsModelProvider);
  return await wods.getWODs();
});

final selectedEventsProvider = FutureProvider.autoDispose<Map<DateTime, List<dynamic>>>((ref) async {
  // Return a Map Date List with the Date as Key. This helps to
  // the calendar to display a single day after a user click for more info.
  // final wods = await ref.watch(wodsModelProvider).getWODs();
  final wods = await ref.watch(wodsModelProvider).getWODs();
  Map<DateTime, List<dynamic>> calendarWods = {};
  for (var wod in wods) {
    // TODO CHANGE THIS CREATE DATE FOR -> EXPECTED TRAINING DAY
    final date = DateFormat("yyyy-MM-dd").parse(wod['expected_training_day'] as String);
    if (calendarWods[DateTime.utc(date.year, date.month, date.day)] == null) {
      calendarWods[DateTime.utc(date.year, date.month, date.day)] = [wod];
    } else {
      calendarWods[DateTime.utc(date.year, date.month, date.day)]!.add(wod);
    }
  }
  return calendarWods;
});


