import '../../my_movements/model/my_movements_model.dart';
import '../settings_manager/settings_training_manager.dart';
import '../wod_creator/wod_creator.dart';
/// The `TrainingWeek` class represents a training week.
///
/// It has two required fields in its constructor:
///   - `context`: a `SettingsTrainingManager` object containing all the settings for the training week.
///   - `sessionDuration`: the duration of each session in the training week.
class TrainingWeek {
  TrainingWeek({
    required SettingsTrainingManager context,
    required int sessionDuration,
    required int totalMoves,
  })  : _context = context,
        _sessionDuration = sessionDuration,
        _totalMoves = totalMoves;

  /// The `SettingsTrainingManager` instance associated with this training week.
  final SettingsTrainingManager _context;

  /// The duration of each training session in this week.
  final int _sessionDuration;

  final int _totalMoves;

  /// A temporary variable used to store the ID of a workout of the day.
  int _tempWODID = -1;

  /// A temporary variable used to store the ID of a block.
  int _tempBlockID = -1;

  /// Returns the value of the `tempWODID` field.
  int get tempWODId => _tempWODID;

  /// Sets the value of the `tempWODID` field.
  set tempWODid(int newValue) => _tempWODID = newValue;

  /// Returns the value of the `tempBlockID` field.
  int get tempBlockID => _tempBlockID;

  /// Sets the value of the `tempBlockID` field.
  set tempBlockID(int newValue) => _tempBlockID = newValue;


  /// A list of [WODCreator] objects representing all the WODs in the training week.
  List<WODCreator> _wods = [];

  /// A map containing the maximum frequency of each muscle in the training week.
  final Map<String, int> _musclesMaxFreq = {};

  // The maximum number of iterations allowed when searching for a movement.
  int _maxIterCounter = 100;

  /// Decrement the value of [_maxIterCounter] by 1.
  void restMaxIterationCounter() => _maxIterCounter--;

  /// Get the current value of [_maxIterCounter].
  int get maxIterCounter => _maxIterCounter;

  /// Reset the value of [_maxIterCounter] to its original value (100).
  void resetMaxIterationCounter() => _maxIterCounter = 200;

  /// Return `true` if the value of [_maxIterCounter] is zero, `false` otherwise.
  bool isMaxIterCounterZero() {
    return _maxIterCounter <= 0;
  }

  // Get the context of the object
  SettingsTrainingManager get context => _context;

  Map<String, int> get musclesMaxFreq => _musclesMaxFreq;

  /// Add the [sets] of the muscle [muscleName] to the [MusclesFrequency] dictionary.
  ///
  /// If the muscle is already in the dictionary, the value will be incremented by [sets].
  /// If the muscle is not in the dictionary, a new key-value pair will be added
  void setMuscleFreq(String muscleName, int sets) {
    // Add The set of the [MusclesFrequency]
    // Apply the [setMuscleFreq] to increase the muscle count of the week.
    if (_musclesMaxFreq.containsKey(muscleName)) {
      _musclesMaxFreq[muscleName] = _musclesMaxFreq[muscleName]! + sets;
    } else {
      _musclesMaxFreq[muscleName] = sets;
    }
  }

  /// Check if it is possible to add a muscle frequency to the map.
  ///
  /// @param muscleName Name of the muscle to add.
  /// @param sets Sets of the muscle to add.
  /// @return True if it is possible to add the muscle frequency, false otherwise.
  bool isSelectedMuscleFreqAvailable(String muscleName, int sets) {
    // Check if the muscle already exists in the map
    int currentSets = _musclesMaxFreq[muscleName] ?? 0;
    // Check if the total sets of the muscle plus the new sets is less than 25
    return currentSets + sets <= 25;
  }

  // Get the Session Duration of the WOD.
  int get sessionDuration => _sessionDuration;

  /// Returns the list of `WODCreator` instances associated with this training week.
  List<WODCreator> get wods => _wods;

  // The total WODs in the training week.
  int get totalWODS => wods.length;

  // Is the total Move in the Training Week.
  // This tribute is create at the beginning because
  // this helps to avoid to duplicate move or have errors.
  int get totalMoves => _totalMoves;

  // Initialize all the Wods.
  Future<void> initWODS() async => await _initChildContext();

  // Initialize the Blocks inside the WOD
  Future<void> initWODSBlocks() async => await _initChildChildrenContext();

  // Extract the context of the Setting Manger
  Future<void> initContext() async => await _initContext();

  // Set all the WOD in the class.
  void setWODS(List<WODCreator> WODS) => _wods = WODS;

  Future<void> _initContext() async {
    // Initialize the context to setUp their respective values
    //
    // In this case the context represent the values of all the WODs
    // so the training week class would create all the wods inside.
    List<WODCreator> WODS = [];
    for (int i in context.listIndexWODS) {
      WODCreator wod = WODCreator(
          context: this,
          index: i,
          bodyArea: context.musclesAreas[i],
          expectedTrainingDate: context.trainingDates[i],
          blocksGeneralInformation: {
            'mode': context.blockModes[i],
            'sets': context.setsInBlocks[i],
            'duration': context.blocksDuration[i],
          });
      // if the WOD is not expired it will be added and save it
      if (!wod.isExpired) {
        await wod.save();
        WODS.add(wod);
      }
    }
    setWODS(WODS);
  }

  Future<void> _initChildContext() async {
    // Initialize the Child Context.
    //
    // In this case it would create all the blocks inside the wod.
    for (var wod in wods) {
      await wod.initContext();
    }
  }

  Future<void> _initChildChildrenContext() async {
    // Initialize the Child children objects.
    //
    // In this case initialize the Blocks inside the WOD.
    for (var wod in wods) {
      await wod.initBlocks();
    }
  }

  Future<bool> learningMovesIsFull() async {
    // Check if the learning moves is full with all the Movements
    final myMovementsModel = context.ref.watch(myMovementsProvider);
    final response = await myMovementsModel.getAllNoLearned();
    print('totalMoves -> $totalMoves');
    return response.length >= totalMoves;
  }

  @override
  String toString() {
    return 'TrainingWeek(sessionDuration=$sessionDuration, totalMoves=$totalMoves, WODS = $wods)';
  }
}
