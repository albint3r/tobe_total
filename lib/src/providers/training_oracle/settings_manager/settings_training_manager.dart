import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cliente/model/cliente_model_provider.dart';
import 'dart:math';
import '../../wod/controllers/wod_controller_provider.dart';
import '../../wod/model/wod_model_provider.dart';
import '../training_week_creator/training_week_creator.dart';

final settingsManagerProvider =
    Provider.autoDispose<SettingsTrainingManager>((ref) {
  return SettingsTrainingManager(ref: ref);
});

/// A class for managing training settings.
///
/// The `SettingsTrainingManager` class allows for the management
/// of training settings, including the session duration,
/// muscles areas of the week, blocks duration of the week,
/// block mode of the week, sets in blocks of the week, and training dates.
/// The `SettingsTrainingManager` constructor takes the `ref` parameter,
/// which is used to initialize the corresponding field and
/// variable of the new object.
class SettingsTrainingManager {
  SettingsTrainingManager({required ProviderRef<SettingsTrainingManager> ref})
      : _ref = ref;

  /// The provider reference for the current `SettingsTrainingManager` object.
  final ProviderRef<SettingsTrainingManager> _ref;

  /// The duration of each training session.
  late final int _sessionDuration;

  /// A list of the muscle areas targeted in each training session of the week.
  late final List<String> _musclesAreasOfTheWeek;

  /// A list of the durations of the blocks in each training session of the week.
  late final List _blocksDurationOfTheWeek;

  /// A list of the modes of the blocks in each training session of the week.
  late final List _blockModeOfTheWeek;

  /// A list of the number of sets in each block of each
  /// training session of the week.
  late final List _setsInBlocksOfTheWeek;

  /// A list of the training dates for each training session of the week.
  late final List<DateTime> _trainingDates;

  int totalMovesInWeek = 0;

  int get sessionDuration => _sessionDuration;

  List<String> get musclesAreas => _musclesAreasOfTheWeek;

  List<DateTime> get trainingDates => _trainingDates;

  List get blockModes => _blockModeOfTheWeek;

  List get setsInBlocks => _setsInBlocksOfTheWeek;

  List get blocksDuration => _blocksDurationOfTheWeek;

  int get totalWODS => _musclesAreasOfTheWeek.length;

  ProviderRef<SettingsTrainingManager> get ref => _ref;

  /// Returns a list of integers representing the indices of the
  /// training sessions in the week.
  List<int> get listIndexWODS {
    // Generate a list of integers from 0 to the total number of
    // training sessions in the week
    return Iterable<int>.generate(totalWODS).toList();
  }

  /// Initiates the creation of a training week by calling a series
  /// of private methods to set the muscle areas, training dates,
  /// block durations, modes, and sets for each training session.
  ///
  /// Returns a [Future] object with the resulting [TrainingWeek] object.
  Future<TrainingWeek> initTrainingCreation() {
    // Call the private _initTrainingCreation()
    // method to initiate the creation process
    return _initTrainingCreation();
  }

  int selectTrainingDays(
      int level, List<Map<String, Object?>> response) {
    int trainingDays;
    if (level != 0) {
      trainingDays = response[0]['total_training_days'] == null
          ? 0
          : response[0]['total_training_days'] as int;
    } else {
      trainingDays = 3;
    }
    return trainingDays;
  }

  /// A private method that calls other private methods to set the muscle areas,
  /// training dates, block durations, modes, and sets for each
  /// training session, as well as creating a client object and getting
  /// the total number of training days.
  ///
  /// Returns a [Future] object with the resulting [TrainingWeek] object.
  Future<TrainingWeek> _initTrainingCreation() async {
    // Get the client object from the provider reference
    final client = _ref.watch(clientProvider);
    // Get the total number of training days from the client object
    final response = await client.getTotalTrainingDays();
    int trainingDays = selectTrainingDays(client.level, response);
    // Call the getTrainingWeekMuscleDistribution() method to
    // set the muscle areas for each training session of the week
    await getTrainingWeekMuscleDistribution(
      client.level,
      trainingDays,
      // this callbacks only apply for noobs
      client.updateTrainingDaysToNoobs,
      client.updateClientValuesTrainingDaysToNoobs,
    );
    // Call the getTrainingDatesOfTheWeek() method to set the
    // training dates for each training session of the week
    await getTrainingDatesOfTheWeek();
    print('-------------------------');
    print(trainingDates);
    print('-------------------------');
    // Call the getExpectedWodDuration() method to set the
    // duration for each training session
    getExpectedWodDuration(
      client.timeToTrain,
    );
    // Call the getBlocksCombinationsDuration() method to set
    // the durations of the blocks for each training session of the week
    await getBlocksCombinationsDuration();
    // Call the getBlocksMode() method to set the modes of the blocks
    // for each training session of the week
    getBlocksMode();
    // Call the getSetsInBlocks() method to set the number of sets
    // for each block of each training session of the week
    getSetsInBlocks();
    // Get all the total moves in the week
    getTotalMoves();
    // Return the resulting TrainingWeek object
    return createTrainingWeek();
  }

  /// [Calculates] the expected duration of a training session based on the
  /// total time the client has available to train and some arbitrary
  /// values for stretch time and expected waste time.
  ///
  /// Sets the `_sessionDuration` variable with the resulting value.
  void getExpectedWodDuration(int timeToTrain) {
    // Constants for the time spent on stretching before and after
    // a training session
    const int startStretchTime = 5;
    const int endStretchTime = 5;
    // If the total time to train is 15 minutes or less, set the
    // session duration to 10 minutes
    if (timeToTrain <= 15) {
      _sessionDuration = 10;
      return;
    }
    // Calculate the expected waste time based on the total time to
    // train (arbitrarily set to 15 minutes per hour)
    final int wasteTimeExpected = (timeToTrain ~/ 60) * 15;
    // Set the session duration based on the total time to train,
    // minus the stretch times and the expected waste time
    _sessionDuration =
        timeToTrain - (startStretchTime + endStretchTime + wasteTimeExpected);
  }

  /// Generates a list of possible combinations of block durations
  /// for each training session of the week, based on the `_sessionDuration`
  /// and a list of possible durations.
  ///
  /// Calls the `selectBlocksOfTheWeek()` method to select the combinations
  /// for each training session of the week.
  ///
  /// Example:
  //  {[10, 15, 15, 15], [8, 8, 12, 12, 15],
  //  [15, 20, 20], [10, 10, 10, 10, 15],
  //  [8, 8, 8, 8, 8, 15], [8, 12, 15, 20],
  //  [10, 10, 15, 20], [8, 10, 10, 12, 15]}
  Future<void> getBlocksCombinationsDuration() async {
    // List to store the possible combinations of block durations
    List blocksDurationCombinations = [];
    // List of possible block durations
    const List<int> blocksDuration = [10, 15, 20];
    // Recursive function to generate the combinations of block durations
    void recursion(List subset) {
      // Iterate through the list of possible block durations
      for (int duration in blocksDuration) {
        // Create a new list by concatenating the current subset
        // with the current duration
        List<int> concatDurations = List.from(subset);
        concatDurations.addAll([duration]);
        // Calculate the total time of the current combination
        final int totalTimeCombinations =
            concatDurations.reduce((a, b) => a + b);
        // If the total time is less than the session duration,
        // call the function again with the concatenated list
        if (totalTimeCombinations < _sessionDuration) {
          recursion(concatDurations);
        }
        // If the total time is equal to the session duration,
        // add the combination to the list and sort it
        else if (totalTimeCombinations == _sessionDuration) {
          concatDurations.sort();
          blocksDurationCombinations.add(concatDurations);
        }
      }
    }

    // Call the recursive function with an empty list
    recursion([]);
    // Call the selectBlocksOfTheWeek() method to select the
    // combinations for each training session of the week
    await selectBlocksOfTheWeek(blocksDurationCombinations);
  }

  /// Selects combinations of block durations for each training session
  /// of the week from a list of possible combinations, based on the
  /// total number of training days for the client.
  ///
  /// Sets the `_blocksDurationOfTheWeek` variable with the selected
  /// combinations.
  Future<void> selectBlocksOfTheWeek(List blocksCombinations) async {
    // Get the client object from the provider reference
    final client = _ref.watch(clientProvider);
    // Get the total number of training days from the client object
    final response = await client.getTotalTrainingDays();
    final int trainingDays = response[0]['total_training_days'] == null
        ? 0
        : response[0]['total_training_days'] as int;
    // Create a random number generator
    Random random = Random();
    // List to store the final selected combinations of block durations
    List finalBlocksSelected = [];
    // Select combinations until the desired number of training days is reached
    while (trainingDays > finalBlocksSelected.length) {
      // Generate a random index
      int randomIndex = random.nextInt(blocksCombinations.length);
      // Add the combination at the random index to the final list
      finalBlocksSelected.add(blocksCombinations[randomIndex]);
      // Remove the selected combination from the list of possible combinations
      finalBlocksSelected.remove(randomIndex);
    }
    _blocksDurationOfTheWeek = finalBlocksSelected;
  }

  /// Gets the muscle [areas] to be trained for each training session
  /// of the week based on the client's level and total number of training days.
  ///
  /// If the client is a noob, the muscle areas will be set to 'full_body'
  /// for the first three training sessions. If the client has previous WODs,
  /// the muscle area of the last training session will be used to determine
  /// the muscle areas for the rest of the week. Otherwise, the muscle areas
  /// will be chosen randomly from a list of available muscle areas.
  ///
  /// Sets the `_musclesAreasOfTheWeek` variable with the selected muscle areas.
  Future<void> getTrainingWeekMuscleDistribution(
      int clientLevel,
      int trainingDays,
      updateTrainingDaysToNoobs,
      updateClientValuesToNoobs) async {
    // List to store the selected muscle areas
    List<String>? lastTrainedMuscleArea = [];
    // Get the WODs model object from the provider reference
    final wods = _ref.watch(wodsModelProvider);
    // If the client has no previous WODs
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
        updateClientValuesToNoobs();
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

  /// Returns a list of body areas to be trained for the week based on the
  /// given list of muscle areas and total number of training days.
  ///
  /// The list of body areas will be randomly chosen from a list of available
  /// body areas ('upper' and 'lower'), ensuring that no two consecutive
  /// training sessions target the same muscle area.
  ///
  /// Parameters:
  /// - `muscleAreasDistribution`: a list of the body areas to be trained
  /// in the week. For new clients, this is usually an empty list.
  /// For clients who have trained before with the app, this is a
  /// list with only one value - the last body area in their WODs list.
  /// - `trainingDays`: the total number of days to be trained.
  /// This is used to create the appropriate number of WODs for the week.
  ///
  /// Returns:
  /// - a list of body areas for the week. For example, if `trainingDays`
  /// is 5, the returned list may look like
  /// ['lower', 'upper', 'full_body', 'lower'].
  List<String> getAvailableMuscleAreas(
      List<String> muscleAreasDistribution, int trainingDays) {
    // List of available body areas
    const List<String> bodyAreas = [
      'upper',
      'lower',
    ];
    // Create a random number generator
    Random random = Random();
    // Loop until the length of the muscleAreasDistribution
    // list is equal to the trainingDays value
    while (muscleAreasDistribution.length != trainingDays) {
      // Generate a random index for the bodyAreas list
      int randomIndex = random.nextInt(bodyAreas.length);
      // Select a Body area.
      String bodyArea = bodyAreas[randomIndex];
      // If the muscleAreasDistribution list is empty, add the body area
      if (muscleAreasDistribution.isEmpty) {
        muscleAreasDistribution.add(bodyArea);
      } else {
        // If the last element in the muscleAreasDistribution
        // list is not the same as the body area, add it
        // This ensures that no two consecutive training sessions
        // target the same muscle area
        // This is What we call 24 Rule
        if (muscleAreasDistribution.last != bodyArea) {
          muscleAreasDistribution.add(bodyArea);
        }
      }
    }
    return muscleAreasDistribution;
  }

  /// Creates a list of the [modes] of each [block] in the [WOD].
  ///
  /// The mode determines how the sets and rest times in the block
  /// are structured.
  ///
  /// Returns a list of lists of strings, where each inner list
  /// represents the [mode] of each [block] in a [WOD].
  ///
  /// Example return value: ['round', 'emom', 'emom', 'emom']
  void getBlocksMode() {
    // Create a list to store the modes of each block in the WOD
    List trainingWeekBlocksMode = [];
    // Iterate through the blocks in _blocksDurationOfTheWeek
    for (List blocks in _blocksDurationOfTheWeek) {
      int counter = 0;
      List blocksMode = [];
      // Iterate through the blocks
      for (var _ in blocks) {
        // If the counter is 0 or greater than or equal to 4,
        // set the mode to 'round'
        // Otherwise, set the mode to 'emom'
        if (counter == 0 || counter >= 4) {
          blocksMode.add('round');
        } else {
          blocksMode.add('emom');
        }
        counter++;
      }
      // Add the modes for the current blocks to the trainingWeekBlocksMode list
      trainingWeekBlocksMode.add(blocksMode);
    }
    // Set the _blockModeOfTheWeek field to the trainingWeekBlocksMode list
    _blockModeOfTheWeek = trainingWeekBlocksMode;
  }

  /// Returns a list of the number of [sets] in each [block] of each
  /// training session of the [week].
  ///
  /// This method calculates the number of sets in each block of the week
  /// by iterating through the list of block modes, `_blockModeOfTheWeek`,
  /// and adding 5 sets to each block. The resulting list is then stored
  /// in the private field, `_setsInBlocksOfTheWeek`.
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

  /// Return an array of the [dates] of the current [week].
  ///
  /// This will be used to select only the dates that the user have
  ///
  /// This method returns a list of [DateTime] objects,
  /// each representing a day of the current week. The list starts
  /// with the first day of the week (Monday) and ends with the last
  /// day (Monday).
  ///
  /// Example:
  ///
  ///     getAllDatesOfTheCurrentWeek()
  ///     Output: [2022-12-25, 2022-12-26, 2022-12-27, 2022-12-28,
  ///     2022-12-29, 2022-12-30, 2022-12-31]
  List<DateTime> getAllDatesOfTheCurrentWeek() {
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
        // print(nextDay);
        allDatesOfTheCurrentWeek.add(nextDay);
        // Only for convenience I use the [startDayOfTheWeek] variable name
        // to follow the iteration, and not create another variable name.
        startDayOfTheWeek = nextDay;
      }
    }
    return allDatesOfTheCurrentWeek;
  }

  void getTotalMoves() {
    // Create forward the totalMoves in the Training Week.
    for (List<int> block in blocksDuration) {
      for (int duration in block) {
        // Always divide by Zero
        double result = duration / 5;
        totalMovesInWeek = (result + totalMovesInWeek).toInt();
      }
    }
  }

  /// Returns a list of the dates on which the user will train in
  /// the current week.
  ///
  /// This method retrieves a list of all dates in the current week
  /// and filters them based on the days
  /// that the user has marked as training days in their settings.
  /// It does this by fetching the
  /// training day map from the [clientProvider] and checking if
  /// the value for each day is `1`.
  ///
  /// Returns:
  ///   A list of [DateTime] objects representing the training dates for
  ///   the current week.
  Future<void> getTrainingDatesOfTheWeek() async {
    // Get a list of DateTime objects representing all the dates
    // of the current week.
    List<DateTime> allDatesOfTheCurrentWeek = getAllDatesOfTheCurrentWeek();
    print('allDatesOfTheCurrentWeek-> $allDatesOfTheCurrentWeek');
    // Get the client object and the map of training days.
    final client = _ref.watch(clientProvider);
    Map trainingDays = await client.trainingDayMap();
    // Iterate through the map and add the corresponding dates to the list.
    int index = 0;
    List<DateTime> trainingDates = [];
    for (var day in trainingDays.entries) {
      if (day.value == 1) {
        // If the value in the map is 1, add the corresponding date to the list.
        trainingDates.add(allDatesOfTheCurrentWeek[index]);
      }
      index++;
    }
    _trainingDates = trainingDates;
  }

  /// This method creates a TrainingWeek object and returns it.
  ///
  /// The TrainingWeek object contains the properties
  /// and methods needed to generate
  /// the training week for a client.
  ///
  /// Returns:
  ///     A TrainingWeek object.
  TrainingWeek createTrainingWeek() {
    // This object helps to create all the training week of the client.
    print('-------------trainingWeek------------------------------');
    print('');
    print('');
    TrainingWeek trainingWeek = TrainingWeek(
      context: this,
      sessionDuration: sessionDuration,
      totalMoves: totalMovesInWeek,
    );
    return trainingWeek;
  }
}
