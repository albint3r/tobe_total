import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/features/progress/presentation/calendar/single_icon_day_indicator.dart';
import '../../../../providers/training_week/controllers/training_week_controller.dart';
import '../../../../providers/wod/controllers/wod_controller_provider.dart';


class LineCompleteDaysIndicators extends ConsumerWidget {
  const LineCompleteDaysIndicators({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get a list with all the Wods of the week and their status
    final completeWodsOfTheWeek = ref.watch(completeWodsOfTheWeekProvider);
    return completeWodsOfTheWeek.when(
      error: (error, stackTrace) => Text('Error $error'),
      loading: () => const CircularProgressIndicator(),
      data: (completeWodsData) {
        getDays(completeWodsData, ref);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: getLineIconDaysIndicators(completeWodsData, ref),
        );
      },
    );
  }

  List<SingleIconDayIndicator> getLineIconDaysIndicators(
      List<Map<String, Object?>> completeWods, WidgetRef ref) {
    // Return a list of [SingleIconDayIndicator] with the result of the
    // day complete added to the [IconAvatar].
    Map trainingDaysOfTheWeek = getDays(completeWods, ref);
    List<SingleIconDayIndicator> lineItems = [];
    for (MapEntry wod in trainingDaysOfTheWeek.entries) {
      if (wod.value.isEmpty) {
        lineItems.add(const SingleIconDayIndicator(
            isExpired: true, isComplete: true, isNull: true));
      } else {
        // TODO this part maybe could change
        // right now it receive integer, but in reality they are boolean values.
        lineItems.add(SingleIconDayIndicator(
            isExpired: wod.value['expired'] == 1 ? true : false,
            isComplete: wod.value['did_wod'] == 1 ? true : false,
            isNull: false));
      }
    }
    return lineItems;
  }

  Map getDays(List<Map<String, Object?>> completeWods, WidgetRef ref) {
    // Gather all days of the week and check with the day
    // in SQL if the day WOD is in the day of the week, it will add
    // the Map to the key - value pair.
    // This will return a Map whit 7 keys and some values with empty Maps.
    final allDaysOfTheWek = ref.watch(listAllDayOfTheWeekProvider);
    final calendarController = ref.watch(calendarControllerProvider);
    for (Map wod in completeWods) {
      DateTime date = calendarController
          .parseDateStringToDateFormat(wod['expected_training_day']);
      allDaysOfTheWek['${date.year}-${date.month}-${date.day}'] = wod;
    }
    return allDaysOfTheWek;
  }
}
