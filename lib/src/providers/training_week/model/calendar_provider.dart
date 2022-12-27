import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../wod/model/wod_model_provider.dart';

final calendarMapConversionProvider = Provider<Map<int, String>>((ref) {
  return {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };
});


final focusDayProvider = StateProvider.autoDispose<DateTime>((ref) {
  // This is the current datetime in the calendar
  return DateTime.now();
});

final calendarFormatProvider = StateProvider<CalendarFormat>((ref) {
  // This is the current format of the Calendar
  return CalendarFormat.month;
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

final wodsAllTrainingsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  // Return a list of all the wods. This is when the user
  // hasn't select any day on the calendar. So this will display all the
  // Wods to train.
  // TODO THIS COULD CHANGE: to only show the last 7 trainings created.
  final wods = ref.watch(wodsModelProvider);
  return await wods.getWODs();
});




