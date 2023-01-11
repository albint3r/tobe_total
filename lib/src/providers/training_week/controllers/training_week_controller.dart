import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../wod/model/wod_model_provider.dart';
import '../model/calendar_provider.dart';

final calendarControllerProvider = Provider<CalendarController>((ref) {
  return CalendarController();
});

class CalendarController {
  /// Parse a DateString to DateFormat.
  DateTime parseDateStringToDateFormat(String dateToParse) {
    return DateFormat("yyyy-MM-dd").parse(dateToParse);
  }

  /// This controller manages the SetState of the Other providers in the File.
  void setStateCurrentSelectedDay(WidgetRef ref, DateTime selectedDay) {
    ref.watch(selectedDayProvider.notifier).state = selectedDay;
  }

  /// Set the state of the Focused Day.
  void setStateFocusDayProvider(WidgetRef ref, DateTime focusedDay) {
    ref.watch(focusDayProvider.notifier).state = focusedDay;
  }

  /// Change the format of the Calendar.
  void changeCalendarFormat(WidgetRef ref, CalendarFormat format) {
    if (ref.watch(calendarFormatProvider) != format) {
      ref.watch(calendarFormatProvider.notifier).state = format;
    }
  }

  /// Unselect the day Select in the calendar. This will display another menu in the Card area.
  void unselectDayCalendar(WidgetRef ref) {
    ref.watch(selectedDayProvider.notifier).state = null;
  }

  /// Return the WodsEvents
  List getWODsFromDay(DateTime? day, var data) {
    return data[day] ?? [];
  }
}

final selectedEventsProvider = FutureProvider.autoDispose<Map<DateTime, List<dynamic>>>((ref) async {
  /// Return a Map Date List with the Date as Key. This helps to the calendar
  /// to display a single day after a user click for more info.
  final wods = await ref.watch(wodsModelProvider).getWODs();
  Map<DateTime, List<dynamic>> calendarWods = {};
  for (var wod in wods) {
    /// TODO CHANGE THIS CREATE DATE FOR -> EXPECTED TRAINING DAY
    final date = DateFormat("yyyy-MM-dd").parse(wod['expected_training_day'] as String);
    if (calendarWods[DateTime.utc(date.year, date.month, date.day)] == null) {
      calendarWods[DateTime.utc(date.year, date.month, date.day)] = [wod];
    } else {
      calendarWods[DateTime.utc(date.year, date.month, date.day)]!.add(wod);
    }
  }
  return calendarWods;
});

