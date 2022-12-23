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

final muscleGroupBySetCountProvider =
    FutureProvider.autoDispose<Map<String, Object?>>(
  (ref) async {
    // This return a list of block inside the Wod Selected in calendar.
    // The ID of the wod is provider by the [wodIdProvider].
    final wodId = ref.watch(wodIdProvider);
    final wodsMode = ref.watch(wodsModelProvider);
    List<Map<String, Object?>> fitnessMovesInWod =
        await wodsMode.getAllMovementsInWod(wodId);
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
