import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../block/model/block_model_provider.dart';
import '../../cliente/model/cliente_model_provider.dart';
import '../../training_week/controllers/training_week_controller.dart';
import '../model/wod_model_provider.dart';

class DateTimeManageController {
  /// Finds the first date of the week for the given DateTime.
  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  /// Finds the last date of the week for the given DateTime.
  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  /// Finds the last date of the month for the given DateTime.
  DateTime findLastDateOfTheMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month + 1, 0);
  }

  /// Finds the first date of the month for the given DateTime.
  DateTime findFirstDateOfTheMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, 1);
  }

  /// Finds the last date of the year for the given DateTime.
  DateTime findLastDateOfTheYear(DateTime dateTime) {
    return DateTime(dateTime.year, 12, 31);
  }

  /// Finds the first date of the year for the given DateTime.
  DateTime findFirstDateOfTheYear(DateTime dateTime) {
    return DateTime(dateTime.year, 1, 1);
  }

  /// Returns the date for the next day from the given date.
  DateTime getTomorrow(date) {
    return date.add(const Duration(days: 1));
  }

  /// Returns true if the given date is earlier in the week than today,
  /// false otherwise.
  bool isExpired(DateTime date) {
    DateTime now = DateTime.now();
    // I added a day, because is taking the current day as expired.
    return date.weekday < now.weekday;
  }
}

final dateTimeManageControllerProvider =
    Provider<DateTimeManageController>((ref) {
  return DateTimeManageController();
});

final wodPlanControllerProvider = Provider<WODPlanController>((ref) {
  // Gre the WOd Plan Controller
  return WODPlanController();
});

class WODPlanController {
  void setStateWodIdProvider(WidgetRef ref, int wodId) {
    // Change the state of the [wodIdProvider] for the Id of the WOD selected.
    // help to change of screen between WODs using the Id.
    ref.watch(wodIdProvider.notifier).state = wodId;
  }

  void setStateSelectedWodInformation(WidgetRef ref, Map wod) {
    // This set the state of the current WOD information select to display
    // the data in the next screen.
    ref.watch(selectedWodInformationProvider.notifier).state = wod;
  }
}

final blocksInWodListProvider =
    FutureProvider.autoDispose<List<Map<String, Object?>>>((ref) async {
  // This return a list of block inside the Wod Selected in calendar.
  // The ID of the wod is provider by the [wodIdProvider].
  final blocks = ref.watch(blocksModelProvider);
  final wodId = ref.watch(wodIdProvider);
  return blocks.getBlocksByWodId(wodId);
});

final fitnessMovesInWodProvider =
    FutureProvider.autoDispose<List<Map<String, Object?>>>((ref) async {
  // This return a list of block inside the Wod Selected in calendar.
  // The ID of the wod is provider by the [wodIdProvider].
  final wodId = ref.watch(wodIdProvider);
  final wodsMode = ref.watch(wodsModelProvider);
  return wodsMode.getAllMovementsInWod(wodId);
});

final completeWodsOfTheWeekProvider =
    FutureProvider.autoDispose<List<Map<String, Object?>>>((ref) async {
  // Return a list of the WOD of the Current Week.
  String startDayOfTheWeekDate = ref.watch(startedDayOfTheWeekDateProvider);
  final wodsModel = ref.watch(wodsModelProvider);
  return wodsModel.getWeekExpectedTrainingDays(startDayOfTheWeekDate);
});

final goalProgressDaysProvider = FutureProvider.autoDispose<Map>((ref) async {
  //  TODO ADD A LAST WEEK GOAL CACHE, this will help to
  // avoid that the user change their goal and have another view of their stats
  // example. The user create a 5 day goal, and then he change the goal to 3
  // this will create the false illusion that the user finish all the exercises.

  // 1- Get the client/ WODs Model to extract the trainingDays Goal
  final clientModel = ref.watch(clientProvider);
  final wodsModel = ref.watch(wodsModelProvider);
  // 2- Get the started day of the week to make the query
  // of the days in the current week.
  String startDayOfTheWeekDate = ref.watch(startedDayOfTheWeekDateProvider);
  // 3 - Make call to the DB.
  List<Map> expectedTrainingDays =
      await wodsModel.getWeekExpectedTrainingDays(startDayOfTheWeekDate);
  List<Map> actualTrainingDaysGoal = await clientModel.getTotalTrainingDays();

  // Transform values to manage:
  int goal = actualTrainingDaysGoal[0]['total_training_days'];
  int currentTrainedDays = 0;
  // If the day is Empty, this means he don't have any WOD this week.
  // Also, is important to know if the user have a [goal].
  if (expectedTrainingDays.isEmpty && goal == 0) {
    return {'goalPer': 0.0, 'currentTrainedDays': 0, 'goal': goal};
  } else {
    for (Map wod in expectedTrainingDays) {
      int tempDayToCount = wod['did_wod'] ?? 0;
      currentTrainedDays = currentTrainedDays + tempDayToCount;
    }
  }
  // This division give you a percentage that would be displayed in the barr.

  return {
    'goalPer': currentTrainedDays / goal,
    'currentTrainedDays': currentTrainedDays,
    'goal': goal
  };
});

/// This return the [REAL] total days trained fo the [Week].
/// Thus select all the trained [WOD] in the Week and sum all the
/// [training] time specified.
final totalTrainedTimeProvider = FutureProvider.autoDispose<int>(
  (ref) async {
    String startDayOfTheWeekDate = ref.watch(startedDayOfTheWeekDateProvider);
    final wodModel = ref.watch(wodsModelProvider);
    final result = await wodModel.getTotalTrainedTime(startDayOfTheWeekDate);
    if (result.isEmpty) {
      return 0;
    } else {
      Map value = result[0];
      // if the value inside is null, it will return 0
      return value['trained_time'] ?? 0;
    }
  },
);

final listAllDayOfTheWeekProvider = StateProvider<Map>((ref) {
  // Return a dict with the key value as the Date and the values as a empty dict or
  // a dict with data. This data is the WODs of that day.

  // 1- Get The startedDay of the week as string
  String startDayOfTheWeekDate = ref.watch(startedDayOfTheWeekDateProvider);
  // 2- Extract the controller to parse the string
  final calendarController = ref.watch(calendarControllerProvider);
  // 3- Get the parse string in DateFormat
  DateTime startDayDate =
      calendarController.parseDateStringToDateFormat(startDayOfTheWeekDate);
  Map weekDays = {};
  int daysCounter = 6;
  // 4- Iterate over all the days of the week.
  while (daysCounter >= 0) {
    // add the DateFormat as key and a empty dict
    // the dict will be filled in other Method. This is only a prepare.
    weekDays['${startDayDate.year}-${startDayDate.month}-${startDayDate.day}'] =
        {};
    // Add one to the current day to create the list.
    startDayDate = DateTime.utc(
        startDayDate.year, startDayDate.month, startDayDate.day + 1);
    daysCounter--;
  }
  return weekDays;
});

final muscleGroupBySetCountProvider =
    FutureProvider.autoDispose<Map<String, Object?>>(
  (ref) async {
    // This return a list of block inside the Wod Selected in calendar.
    // The ID of the wod is provider by the [wodIdProvider].
    final wodId = ref.watch(wodIdProvider);
    final wodsModel = ref.watch(wodsModelProvider);
    List<Map<String, Object?>> fitnessMovesInWod =
        await wodsModel.getAllMovementsInWod(wodId);
    // Check if the list is empty
    Map<String, int> muscleGroupBySetCount = {};
    if (fitnessMovesInWod.isNotEmpty) {
      for (Map move in fitnessMovesInWod) {
        String muscle = move['muscle_prota'];
        int sets = move['sets'];
        if (muscleGroupBySetCount[muscle] == null) {
          muscleGroupBySetCount[muscle] = sets;
        } else {
          muscleGroupBySetCount[muscle] = sets + muscleGroupBySetCount[muscle]!;
        }
      }
    }
    sortMapValues(muscleGroupBySetCount);
    return sortMapValues(muscleGroupBySetCount);
  },
);

Map<String, int> sortMapValues(Map<String, int> mapToSort) {
  // This function Sort the Map by their values.
  // Here compare the values to sort
  List<String> sortedKeys = mapToSort.keys.toList(growable: true)
    ..sort((k1, k2) => mapToSort[k1]!.compareTo(mapToSort[k2]!));
  // Add the Sorted Values to a new map
  Map<String, int> sortedMap = {};
  for (String key in sortedKeys) {
    sortedMap[key] = mapToSort[key] as int;
  }
  return sortedMap;
}
