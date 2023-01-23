import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:tobe_total/src/features/training_week_calendar/presentation/card_wod_in_week_training.dart';
import '../../../providers/training_week/controllers/training_week_controller.dart';
import '../../../providers/training_week/model/calendar_provider.dart';
import '../../../providers/theme/is_dark_mode_provider.dart';
import '../../common_widgets/headers_screens/header_screens.dart';
import 'no_wods_banner.dart';

class CalendarDisplay extends ConsumerWidget {
  const CalendarDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvents = ref.watch(selectedEventsProvider);
    final allTrainingDays = ref.watch(wodsAllTrainingsProvider);
    bool isDarkMode = ref.watch(isDarkModeProviderNotifier);

    return selectedEvents.when(
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgressIndicator(),
        data: (wodData) {
          final calendarController = ref.watch(calendarControllerProvider);
          // Is a day selected in the calendar?
          // if this is true this will be display only that WOD.
          final selectedWodsDay = calendarController.getWODsFromDay(
              ref.watch(selectedDayProvider), wodData);
          return ListView(
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
                    calendarController.getWODsFromDay(day, wodData),
                // Selector style
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
                  calendarController.setStateFocusDayProvider(ref, focusedDay);
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
              // This provider extract return a list of MAPS
              // with all the WODs created. If the list is empty
              // this means there is not WODS created yet.
              // Whe add a list in all the elements because to display a Message
              // when the user don't have any WOD yer.
              ...allTrainingDays.when(
                error: (err, stack) => [Text('Error: $err')],
                loading: () => [const CircularProgressIndicator()],
                data: (allWodsData) {
                  // If user don't have any WODs it will display it
                  // a banner to show a legend -> Dont exist Yet movements
                  if (selectedWodsDay.isEmpty & allWodsData.isEmpty) {
                    return [
                      WODsCardInformation(selectedWodsDay: allWodsData, isSelectedUniqueDay: false,),
                      // This is the Card with the msg of no wod create.
                      const MessageNoWOD(),
                    ];
                  }
                  return selectedWodsDay.isNotEmpty
                      // This only display the selected day in the calendar.
                      ? [WODsCardInformation(selectedWodsDay: selectedWodsDay, isSelectedUniqueDay: true,)]
                      // This display all days
                      : [WODsCardInformation(selectedWodsDay: allWodsData, isSelectedUniqueDay: false,)];
                },
              )
              // WODsInformation(selectedWodsDay: selectedWodsDay),
            ],
          );
        });
  }
}
