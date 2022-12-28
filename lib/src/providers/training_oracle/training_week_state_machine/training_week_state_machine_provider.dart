import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cliente/model/cliente_model_provider.dart';

final trainingWeekStateMachineProvider =
    Provider<TrainingWeekStateMachine>((ref) {
  return TrainingWeekStateMachine(ref: ref);
});

class TrainingWeekStateMachine {
  TrainingWeekStateMachine({required ProviderRef<TrainingWeekStateMachine> ref})
      : _ref = ref;
  final ProviderRef<TrainingWeekStateMachine> _ref;
  late final int _trainingSessionDuration;
  late final int _trainingDays;
  late final int _trainingTime;
  late final int _goal;
  late final Map<String, bool> _trainingEquipment;


  void _initState() {
    final client = _ref.watch(clientProvider);
  }

  void getExpectedWodDuration() async {
    // Calculate the training duration of the client.
    //
    // This method help to reduce the client expected workout.
    // We penalize the duration with arbitrarily values of the expected wast time of the athlete
    const int startStretchTime = 10;
    const int endStretchTime = 10;
    //  By default, we expect each hour client lose 15 minutes.
    //  The below formula only reduce 15 min if is 1, 2, 3
    //  It won't do anything if -> 1.5, this will only reduce 1 hour.
    // Get the training time of the client
    // this will be converted in a time of total training.
    final client = _ref.watch(clientProvider);
    List<Map<String, Object?>> response = await client.getTotaTrainingTime();
    Map<String, Object?> clientTrainingTime = response[0];
    int timeToTrain = clientTrainingTime['time_to_train'] as int ?? 0;
    final int wasteTimeExpected = (timeToTrain ~/ 60) * 15;
    // Set value in state
    _trainingSessionDuration =
        timeToTrain - (startStretchTime + endStretchTime + wasteTimeExpected);
  }

  Set getBlocksCombinationsDuration(List<int> blocksDuration, int sessionDuration) {
    // Generate all possible block duration in the User Wod.
    // Parameters:
    // -----------
    // blocksDuration: list
    // Is a list of integers that represent the duration of X training bloc.
    // Example:
    //
    // [8, 10, 12, 15, 20]
    //
    // 8 min
    // 10 min
    // 12 min
    // 15 min
    // 20 min
    //
    // sessionDuration: int
    // This is the duration in minutes of the training session. With this value, the program can calculate
    // how many block can achieve in their training.
    //
    // Returns:
    // ----------
    // set[List]
    //
    // Example:
    // {[10, 15, 15, 15], [8, 8, 12, 12, 15],
    // [15, 20, 20], [10, 10, 10, 10, 15],
    // [8, 8, 8, 8, 8, 15], [8, 12, 15, 20],
    // [10, 10, 15, 20], [8, 10, 10, 12, 15]}

    Set blocksDurationCombinations = {} ;

    void recursion(List subset) {
      for(int duration in blocksDuration) {
        // 1- Concatenate all the Duration
        // Create Concatenated list to avoid add duration to the same list.
        List<int> concatDurations = List.from(subset);
        concatDurations.addAll([duration]);
        // 2- Sum all duration in the concatenated list
        final int totalTimeCombinations =  concatDurations.reduce((a, b) => a + b);
        // If the [total time combination] are less than the [session duration]
        // this will let you to get another recursion.
        if(totalTimeCombinations < sessionDuration) {
          // Because subset is already combined this will be the new list input
          recursion(concatDurations);
        } else if (totalTimeCombinations == sessionDuration) {
          concatDurations.sort();
          blocksDurationCombinations.add(concatDurations);
        }
      }
    }
    recursion([]);
    return blocksDurationCombinations;
  }

}


