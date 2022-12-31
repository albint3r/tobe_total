import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cliente/model/cliente_model_provider.dart';
import 'dart:math';
import '../../wod/controllers/wod_controller_provider.dart';
import '../../wod/model/wod_model_provider.dart';
import '../training_week_creator/training_week_creator.dart';
import '../wod_creator/wod_creator.dart';

final settingsManagerProvider =
    Provider.autoDispose<SettingsTrainingManager>((ref) {
  return SettingsTrainingManager(ref: ref);
});

class SettingsTrainingManager {
  SettingsTrainingManager({required ProviderRef<SettingsTrainingManager> ref})
      : _ref = ref;
  final ProviderRef<SettingsTrainingManager> _ref;
  late final int _sessionDuration;
  late final List<String> _musclesAreasOfTheWeek;
  late final List _blocksDurationOfTheWeek;
  late final List _blockModeOfTheWeek;
  late final List _setsInBlocksOfTheWeek;
  late final List<DateTime> _trainingDates;


  // Get the total WODS of the client
  int get sessionDuration => _sessionDuration;
  List<String> get musclesAreas => _musclesAreasOfTheWeek;
  List<DateTime> get trainingDates => _trainingDates;
  List get blockModes => _blockModeOfTheWeek;
  List get setsInBlocks => _setsInBlocksOfTheWeek;
  List get blocksDuration => _blocksDurationOfTheWeek;

  int get totalWODS => _musclesAreasOfTheWeek.length;
  ProviderRef<SettingsTrainingManager> get ref => _ref;
  // Create a list of index of the length size of the total client WODs.
  List<int> get listIndexWODS => Iterable<int>.generate(totalWODS).toList();

  Future<TrainingWeek> initTrainingCreation() {
    // Initiate the creation of all the aspect of the Training Week
    return _initTrainingCreation();
  }

  Future<TrainingWeek> _initTrainingCreation() async {
    // Create Client
    final client = _ref.watch(clientProvider);
    final response = await client.getTotalTrainingDays();
    final int trainingDays = response[0]['total_training_days'] == null
        ? 0
        : response[0]['total_training_days'] as int;

    await getTrainingWeekMuscleDistribution(
      client.level,
      trainingDays,
      client.updateTrainingDaysToNoobs,
    );
    await getTrainingDatesOfTheWeek();
    getExpectedWodDuration(
      client.timeToTrain,
    );
    await getBlocksCombinationsDuration();
    getBlocksMode();
    getSetsInBlocks();

    return createTrainingWeek();
  }

  void getExpectedWodDuration(int timeToTrain) {
    // Calculate the training duration of the client.
    //
    // This method help to reduce the client expected workout.
    // We penalize the duration with arbitrarily values of the expected wast time of the athlete
    const int startStretchTime = 5;
    const int endStretchTime = 5;
    //  By default, we expect each hour client lose 10 minutes.
    // If the client put less than 15 minutes
    // without this would have error because the penalization
    // don't return a valid value.
    if (timeToTrain <= 15) {
      _sessionDuration = 10;
      return;
    }
    //  The below formula only reduce 15 min if is 1, 2, 3
    //  It won't do anything if -> 1.5, this will only reduce 1 hour.
    // Get the training time of the client
    // this will be converted in a time of total training.
    final int wasteTimeExpected = (timeToTrain ~/ 60) * 15;
    // Set value in state
    _sessionDuration =
        timeToTrain - (startStretchTime + endStretchTime + wasteTimeExpected);
  }

  Future<void> getBlocksCombinationsDuration() async {
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

    List blocksDurationCombinations = [];
    const List<int> blocksDuration = [10, 15, 20];
    void recursion(List subset) {
      for (int duration in blocksDuration) {
        // 1- Concatenate all the Duration
        // Create Concatenated list to avoid add duration to the same list.
        List<int> concatDurations = List.from(subset);
        concatDurations.addAll([duration]);
        // 2- Sum all duration in the concatenated list
        final int totalTimeCombinations =
            concatDurations.reduce((a, b) => a + b);
        // If the [total time combination] are less than the [session duration]
        // this will let you to get another recursion.
        if (totalTimeCombinations < _sessionDuration) {
          // Because subset is already combined this will be the new list input
          recursion(concatDurations);
        } else if (totalTimeCombinations == _sessionDuration) {
          concatDurations.sort();
          blocksDurationCombinations.add(concatDurations);
        }
      }
    }

    recursion([]);

    // This Method select only the number of day the client
    // would train.
    await selectBlocksOfTheWeek(blocksDurationCombinations);
  }

  Future<void> selectBlocksOfTheWeek(List blocksCombinations) async {
    // Select the final Blocks of the Week inside each WOD
    //
    // The method receives a bast list of possible combinations
    // and select only N combinations, where N is equal of the
    // total training day of the client.

    // 1- Create object [client] to extract training days
    final client = _ref.watch(clientProvider);
    final response = await client.getTotalTrainingDays();
    final int trainingDays = response[0]['total_training_days'] == null
        ? 0
        : response[0]['total_training_days'] as int;
    // 2- Create [random] Object to select random items in the combinations
    Random random = Random();
    // 3- Have a empty list that would hold the final results
    List finalBlocksSelected = [];
    // 4- Iterate until the list have the same length of the training Days
    while (trainingDays > finalBlocksSelected.length) {
      // Select a index
      int randomIndex = random.nextInt(blocksCombinations.length);
      finalBlocksSelected.add(blocksCombinations[randomIndex]);
      // Remove the selected item
      finalBlocksSelected.remove(randomIndex);
    }
    // Assign the final result
    _blocksDurationOfTheWeek = finalBlocksSelected;
  }

  Future<void> getTrainingWeekMuscleDistribution(
      int clientLevel, int trainingDays, updateTrainingDaysToNoobs) async {
    // Depending on the last WOD body area trained it will Create the Week areas to train without areas coalitions.
    //
    //     These means that each muscle areas need to rest 24 hours. Because each result represent a day, this will
    //     assure that the client never train the same are twice with not stop.
    //
    //     client_level: int:
    //         Is the level of the client. Depending on this it will be selected the WODs of the Week.
    //
    //     total_training_days: int:
    //         Is the total number of day to train. Depending on this it will be created the N numbers of WOD on the week.
    //
    //     Returns:
    //     --------
    //     list[str]

    List<String>? lastTrainedMuscleArea = [];
    final wods = _ref.watch(wodsModelProvider);
    if (!await wods.isWODsExist()) {
      // if the client level is Noob
      if (clientLevel == 0) {
        // All the noobs the first two week would have noobs trainings.
        // To conditioned the client
        lastTrainedMuscleArea = ['full_body', 'full_body', 'full_body'];
        // change training days of the client
        // this is needed because the athlete needs to have a 24 hours of rest
        // between muscles areas, but in these case We area training
        // the full body, so because that Is necessary to reduce the training days
        // to 3, or in other cases add one day.
        await updateTrainingDaysToNoobs();
      } else {
        lastTrainedMuscleArea =
            getAvailableMuscleAreas(lastTrainedMuscleArea, trainingDays);
      }
    } else {
      // Client had previous WODS in their list
      final response = await wods.getLastMuscleTrained();
      lastTrainedMuscleArea = [response[0]['body_area'] as String];
      // Plus +1 to considerate the list -> last_trained_muscle_area is not empty
      // This will throw an incomplete list, but with 5 values.
      // We need to add one and then pop the first.
      lastTrainedMuscleArea =
          getAvailableMuscleAreas(lastTrainedMuscleArea, trainingDays + 1);
      lastTrainedMuscleArea =
          lastTrainedMuscleArea.sublist(1, trainingDays + 1);
    }
    _musclesAreasOfTheWeek = lastTrainedMuscleArea;
  }

  List<String> getAvailableMuscleAreas(
      List<String> muscleAreasDistribution, int trainingDays) {
    // Return a list of body areas to work out on the week
    //
    //     Parameters:
    //     -----------
    //     muscles_areas_distribution: list
    //         Is a list that contains the body areas to train in the Week. For new clients
    //         usually this is an empty list. But for people how had train before with the app, this
    //         is only a list with one value, this value is the last body area in their WODs list.
    //
    //     total_training_days: int:
    //         Is the total number of day to train. Depending on this it will be created the N numbers of WOD on the week.
    //         It used this number to avoid create more or less WODs on the week.
    //
    //     Returns:
    //     -----------
    //     total_training_days = 5
    //      list[str] -> ['lower', 'upper', 'full_body', 'lower']
    //
    //
    const List<String> bodyAreas = [
      'upper',
      'lower',
    ];
    Random random = Random();
    // Loop Until we have N areas, when N is equal to total training days of the client.
    while (muscleAreasDistribution.length != trainingDays) {
      int randomIndex = random.nextInt(bodyAreas.length);
      String bodyArea = bodyAreas[randomIndex];
      // The list is empty to add a new body area
      if (muscleAreasDistribution.isEmpty) {
        muscleAreasDistribution.add(bodyArea);
      } else {
        // Check the last body area isn't the same.
        // This is called the 24 rule. Is the time a muscle need to rest Between trainings.
        if (muscleAreasDistribution.last != bodyArea) {
          muscleAreasDistribution.add(bodyArea);
        }
      }
    }
    return muscleAreasDistribution;
  }

  void getBlocksMode() {
    // Create a list of the modes of each [block] in the [WOD].
    //
    //     Depending on the Mode it will be created the [SET] and [REST TIME] in the Block.
    //
    //     Parameters:
    //     -----------
    //     blocks_of_the_week: list[tuple[int]]
    //         Is the list of the blocks in the Week. Example ->  [[10,15], [20,10] ...]
    //
    //     Returns:
    //     ----------
    //     list[list[str]]
    //
    //     Example:
    //     ----------
    //     ['round', 'emom', 'emom', 'emom']
    //
    List trainingWeekBlocksMode = [];
    for (List blocks in _blocksDurationOfTheWeek) {
      int counter = 0;
      List blocksMode = [];
      for (var _ in blocks) {
        if (counter == 0 || counter >= 4) {
          blocksMode.add('round');
        } else {
          blocksMode.add('emom');
        }
        counter++;
      }
      trainingWeekBlocksMode.add(blocksMode);
    }
    _blockModeOfTheWeek = trainingWeekBlocksMode;
  }

  void getSetsInBlocks() {
    //Return an Array with the number of set in each block in the [WOD] depending on there time length.
    List trainingWeekSetsInBlocks = <List>[];
    for (List mode in _blockModeOfTheWeek) {
      List sets = <int>[];
      for (var _ in mode) {
        sets.add(5);
      }
      trainingWeekSetsInBlocks.add(sets);
    }
    _setsInBlocksOfTheWeek = trainingWeekSetsInBlocks;
  }

  List<DateTime> getAllDatesOfTheCurrentWeek() {
    // Return an array of the dates of the current week.
    //
    // This will be used to select only the dates that the user have

    // What day is today?
    DateTime today = DateTime.now();
    // Get the [StartDayOfTheWeek] date
    DateTime startDayOfTheWeek = _ref
        .watch(dateTimeManageControllerProvider)
        .findFirstDateOfTheWeek(today);
    List<int> indexDaysOfTheWeek = Iterable<int>.generate(7).toList();
    List<DateTime> allDatesOfTheCurrentWeek = [];

    for (int _ in indexDaysOfTheWeek) {
      if (allDatesOfTheCurrentWeek.isEmpty) {
        allDatesOfTheCurrentWeek.add(startDayOfTheWeek);
      } else {
        DateTime nextDay = _ref
            .watch(dateTimeManageControllerProvider)
            .getTomorrow(startDayOfTheWeek);
        allDatesOfTheCurrentWeek.add(nextDay);
        // Only for convenience I use the [startDayOfTheWeek] variable name
        // to follow the iteration, and not create another variable name.
        startDayOfTheWeek = nextDay;
      }
    }
    return allDatesOfTheCurrentWeek;
  }

  Future<void> getTrainingDatesOfTheWeek() async {
    List<DateTime> allDatesOfTheCurrentWeek = getAllDatesOfTheCurrentWeek();
    final client = _ref.watch(clientProvider);
    Map trainingDays = await client.trainingDayMap();

    int index = 0;
    List<DateTime> trainingDates = [];
    for (var day in trainingDays.entries) {
      if (day.value == 1) {
        trainingDates.add(allDatesOfTheCurrentWeek[index]);
      }
      index++;
    }
    _trainingDates = trainingDates;
  }

  TrainingWeek createTrainingWeek() {
    // This create thw Training week Object
    //
    // This object helps to create all the training week of the client.
    print('-------------trainingWeek------------------------------');
    print('');
    print('');
    TrainingWeek trainingWeek = TrainingWeek(
      context: this,
      sessionDuration: sessionDuration,
    );
    return trainingWeek;
  }
}
