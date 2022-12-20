import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/training_plan_manage/presentation/wods_information.dart';
import '../../../providers/calendar_provider.dart';
import '../../common_widgets/headers_screens/header_screens.dart';

class CalendarDisplay extends ConsumerWidget {
  const CalendarDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wod = ref.watch(selectedEventsProvider);

    return wod.when(
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgressIndicator(),
        data: (data) {
          final calendarController = ref.watch(calendarControllerProvider);
          var selectedWodsDay = calendarController.getWODsFromDay(
              ref.watch(selectedDayProvider), data);
          print('-----------');
          print(selectedWodsDay);
          return Center(
            child: ListView(
              children: [
                const H1Screens(
                  header: 'Training Plan',
                  isInListView: true,
                ),
                const SubTitleHeaderH1(
                    subHeader:
                        'Start your next training or manage all your workouts.'),
                TableCalendar(
                  headerStyle: const HeaderStyle(titleCentered: true),
                  firstDay: DateTime.utc(2022, 1, 1),
                  lastDay: DateTime.utc(2030, 1, 1),
                  focusedDay: ref.watch(focusDayProvider),
                  startingDayOfWeek: ref.watch(startingDayOfWeekProvider),
                  calendarFormat: ref.watch(calendarFormatProvider),
                  eventLoader: (day) =>
                      calendarController.getWODsFromDay(day, data),
                  // Selector style
                  calendarStyle: const CalendarStyle(
                      todayTextStyle: TextStyle(color: Colors.white),
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      )),
                  selectedDayPredicate: (day) {
                    // This helps to select the day if is [true]
                    return isSameDay(ref.watch(selectedDayProvider), day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    // Change the State of the States.
                    final calendarController =
                        ref.watch(calendarControllerProvider);
                    calendarController.setStateCurrentSelectedDay(
                        ref, selectedDay);
                    calendarController.setStateFocusDayProvider(
                        ref, focusedDay);
                  },
                  onFormatChanged: (format) {
                    ref
                        .watch(calendarControllerProvider)
                        .changeCalendarFormat(ref, format);
                  },
                  onPageChanged: (focusedDay) {
                    ref
                        .watch(calendarControllerProvider)
                        .setStateFocusDayProvider(ref, focusedDay);
                  },
                ),
                WODsInformation(selectedWodsDay: selectedWodsDay),
              ],
            ),
          );
        });
  }
}


