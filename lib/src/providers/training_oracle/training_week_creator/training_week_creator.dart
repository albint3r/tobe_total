import '../training_week_state_machine/training_week_state_machine_provider.dart';
import '../wod_creator/wod_creator.dart';

class TrainingWeek {
  TrainingWeek({
    required SettingsTrainingManager context,
    required int sessionDuration,
  })  : _context = context,
        _sessionDuration = sessionDuration;
  final SettingsTrainingManager _context;
  final int _sessionDuration;
  List<WODCreator> _wods = [];

  // Get the context of the object
  SettingsTrainingManager get context => _context;

  // Get the Session Duration of the WOD.
  int get sessionDuration => _sessionDuration;

  List<WODCreator> get wods => _wods;

  // The total WODs in the training week.
  int get totalWODS => wods.length;

  // Initialize all the Wods.
  void initWODS() => _initChildContext();

  // Initialize the Blocks inside the WOD
  void initWODSBlocks() => _initChildChildrenContext();

  // Extract the context of the Setting Manger
  void initContext() => _initContext();

  // Set all the WOD in the class.
  void setWODS(List<WODCreator> WODS) => _wods = WODS;

  void _initContext() {
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
      WODS.add(wod);
      // print('--------STATUS WOD-------------');
      // print(wod);
      // print('Is expired -> [${wod.isExpired}]');
      // print('');
    }
    setWODS(WODS);
  }

  void _initChildContext() {
    // Initialize the Child Context.
    //
    // In this case it would create all the blocks inside the wod.
    for (var wod in wods) {
      wod.initContext();
    }
  }

  void _initChildChildrenContext() {
    // Initialize the Child children objects.
    //
    // In this case initialize the Blocks inside the WOD.
    for (var wod in wods) {
      wod.initBlocks();
    }
  }

  @override
  String toString() {
    return 'TrainingWeek(sessionDuration=$sessionDuration, WODS = $wods)';
  }
}
