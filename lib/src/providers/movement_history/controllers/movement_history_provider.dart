import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tobe_total/src/providers/wod/controllers/wod_controller_provider.dart';
import '../model/movement_history_model.dart';

/// A provider that returns a `Future` that completes with a `Map` object
/// containing the total count of the difficulty of movement and a
/// list of the difficulties.
final difficultyCountProvider =
    FutureProvider.autoDispose<Map<dynamic, dynamic>>((ref) async {
  /// Get the current date
  DateTime today = DateTime.now();

  /// Get the [MovementHistoryModel] instance
  final movementHistoryModel = ref.watch(movementHistoryModelProvider);

  /// Get the [DateTimeManageController] instance
  final dateTimeManageController = ref.watch(dateTimeManageControllerProvider);

  /// Get the first date of the current week
  DateTime startDayOfTheWeek =
      dateTimeManageController.findFirstDateOfTheWeek(today);

  /// Get a list of difficulty counts by passing the start date
  /// of the current week
  final difficultyCount = await movementHistoryModel.getDifficultyCount(
      startDayOfTheWeek: startDayOfTheWeek.toString().substring(0, 10));
  /// Create a Map object that will be returned by the provider.
  Map result = {'total': 0, 'difficulties': {}};

  /// Iterate over the list of difficulties to get the total
  /// count of difficulties
  for (Map data in difficultyCount) {
    result['total'] = result['total'] + data['difficulty_count'];
  }

  /// Add the difficulties to the result Map object
  result['difficulties'] = difficultyCount;
  return result;
});

final trainedMovesOfTheCurrentWeekProvider =
    FutureProvider<List<Map<String, Object?>>>((ref) async {
  final movementHistoryModel = ref.watch(movementHistoryModelProvider);
  final dateTimeManage = ref.watch(dateTimeManageControllerProvider);
  DateTime startDayOfTheWeek =
      dateTimeManage.findFirstDateOfTheWeek(DateTime.now());
  return await movementHistoryModel.getTrainedMovementsOfTheCurrentWeek(
      startDayOfTheWeek.toString().substring(0, 10));
});

final caloriesTrainedWeekProvider = FutureProvider<int>((ref) async {
  final caloriesBurnPerMinute = ref.watch(caloriesBurnPerMinuteByDifficultyProvider);
  final List<Map<String, Object?>> moves = await ref.watch(trainedMovesOfTheCurrentWeekProvider.future);
  int caloriesBurnedCalculation = 0;
  if(moves.isNotEmpty) {
    for(Map<String, Object?> move in moves) {
      int caloriesBurned = caloriesBurnPerMinute[move['difficulty']!]!;
      caloriesBurnedCalculation = caloriesBurnedCalculation + (caloriesBurned * 5);
    }
  }
  return caloriesBurnedCalculation;
});
