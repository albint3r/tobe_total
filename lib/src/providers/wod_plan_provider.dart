import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:collection';
import '../data_base/model/blocks.dart';
import 'calendar_provider.dart';

class WODPlanController {
  void setStateWodIdProvider(WidgetRef ref, int wodId) {
    // Change the state of the [wodIdProvider] for the Id of the WOD selected.
    ref.watch(wodIdProvider.notifier).state = wodId;
  }

  void setStateSelectedWodInformation(WidgetRef ref, Map wod) {
    // This set the state of the current WOD information select to display
    // the data in the next screen.
    ref.watch(selectedWodInformationProvider.notifier).state = wod;
  }
}

// TODO MOVE THIS TO ANOTHER FILE WITH ALL THE MODELS OF THE DB
final blocksModelProvider = StateProvider<Blocks>((ref) {
  // get the WOD Class
  return Blocks();
});

final wodPlanControllerProvider = Provider<WODPlanController>((ref) {
  // Gre the WOd Plan Controller
  return WODPlanController();
});

final startedDayOfTheWeekDateProvider = Provider<String>((ref) {
  // Return the string of the Started day of the week date. This helps
  // to create the days complete of the client in the progress section.
  final DateTime today = DateTime.now();
  // We rest 1  to penalize the days and have the exact start day of the week.
  int startDayOfTheWeek = today.day - (today.weekday -1);
  return '${today.year}-${today.month}-$startDayOfTheWeek';
});

final selectedWodInformationProvider = StateProvider<Map>((ref) {
  // This help to select the current information of the WOD Card
  return {};
});

final wodIdProvider = StateProvider<int>((ref) {
  // This helps to make the change of screens between the calendar
  // to the wod information
  return -1;
});

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

//TODO FINISH THIS QUERY
final completeWodsOfTheWeekProvider = FutureProvider.autoDispose<List<Map<String, Object?>>>((ref) async {
  // Get a list of all the wods of the day by their status
  String startDayOfTheWeekDate = ref.watch(startedDayOfTheWeekDateProvider);
  final wodsModel = ref.watch(wodsModelProvider);
  return wodsModel.getWeekExpectedTrainingDays(startDayOfTheWeekDate);
});

final listAllDayOfTheWeekProvider = StateProvider<Map>((ref) {

  // 1- Get The startedDay of the week as string
  String startDayOfTheWeekDate = ref.watch(startedDayOfTheWeekDateProvider);
  // 2- Extract the controller to parse the string
  final calendarController  = ref.watch(calendarControllerProvider);
  // 3- Get the parse string in DateFormat
  DateTime startDayDate = calendarController.parseDateStringToDateFormat(startDayOfTheWeekDate);
  Map weekDays = {};
  int daysCounter = 6;
  // 4- Iterate over all the days of the week.
  while(daysCounter >= 0) {
    // add the DateFormat as key and a empty dict
    // the dict will be filled in other Method. This is only a prepare.
    weekDays['${startDayDate.year}-${startDayDate.month}-${startDayDate.day}'] = {};
    // Add one to the current day to create the list.
    startDayDate = DateTime.utc(startDayDate.year, startDayDate.month, startDayDate.day + 1);
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
    // print('getBarGroup');
    // print(fitnessMovesInWod);
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
    // print(muscleGroupBySetCount);
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
