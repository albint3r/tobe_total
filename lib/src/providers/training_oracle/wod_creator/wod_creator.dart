import 'package:tobe_total/src/providers/cliente/model/cliente_model_provider.dart';
import '../../wod/controllers/wod_controller_provider.dart';
import '../../wod/model/wod_model_provider.dart';
import '../block_creator/block_creator.dart';
import '../training_week_creator/training_week_creator.dart';

/// A class for creating Workout of the Day (WOD) objects.
///
/// The `WODCreator` class allows for the creation of new WOD
/// objects, which consist of a set of blocks of exercises that
/// can be saved to the local database. The `WODCreator` constructor
/// takes the `context`, `index`, `bodyArea`, `expectedTrainingDate`,
/// and `blocksGeneralInformation` parameters, which are used to initialize
/// the corresponding fields and variables of the new WOD object.
class WODCreator {
  /// Initializes a new `WODCreator` object.
  ///
  /// This constructor takes the `context`, `index`, `bodyArea`,
  /// `expectedTrainingDate`, and `blocksGeneralInformation`
  /// parameters and uses them to initialize the corresponding
  /// fields and variables of the new object.
  ///
  /// @param [context] The `TrainingWeek` object that is the context
  /// for the current WOD.
  /// @param [index] The index of the WOD within the training week.
  /// @param [bodyArea] The body area targeted by the WOD.
  /// @param [expectedTrainingDate] The expected training date for the WOD.
  /// @param [blocksGeneralInformation] A map containing general
  /// information about the blocks in the WOD.
  WODCreator(
      {required TrainingWeek context,
      required this.index,
      required this.bodyArea,
      required this.expectedTrainingDate,
      required this.blocksGeneralInformation})
      : _context = context;


  /// The `TrainingWeek` object that is the context for the current
  /// Workout of the Day (WOD).
  late final TrainingWeek _context;

  /// The [ID] in [SQL] of the current WOD.
  late int _id;

  /// The index of the WOD within the training week.
  int index;

  /// The body area targeted by the WOD.
  String bodyArea;

  /// The expected training date for the WOD.
  DateTime expectedTrainingDate;

  /// A map containing general information about the blocks in the WOD.
  Map<String, List> blocksGeneralInformation;

  /// A list of `BlockCreator` objects representing the blocks in the WOD.
  final List<BlockCreator> _blocks = [];

  /// Gets a boolean indicating whether the current Workout
  /// of the Day (WOD) is expired.
  ///
  /// This getter retrieves the `DateTimeManageController` from the
  /// `context` and uses it to check if the `expectedTrainingDate`
  /// of the WOD has already passed.
  ///
  /// @return `true` if the WOD is expired, `false` otherwise.
  bool get isExpired => context.context.ref
      .watch(dateTimeManageControllerProvider)
      .isExpired(expectedTrainingDate);

  /// Gets the [ID] in [SQLite] of the current Workout of the Day (WOD).
  ///
  /// This getter returns the `_id` field.
  ///
  /// @return The ID of the WOD.
  int get id => _id;

  /// Sets the ID of the current Workout of the Day (WOD).
  ///
  /// This setter updates the value of the `_id` field.
  ///
  /// @param id The new ID of the WOD.
  set id(int id) => _id = id;

  /// Gets the `TrainingWeek` object that is the context
  /// for the current Workout of the Day (WOD).
  ///
  /// This getter returns the `_context` object.
  ///
  /// @return The context of the WOD.
  TrainingWeek get context => _context;

  /// Gets the list of `BlockCreator` objects in the current
  /// Workout of the Day (WOD).
  ///
  /// This getter returns the `_blocks` list.
  ///
  /// @return The list of blocks in the WOD.
  List<BlockCreator> get blocks => _blocks;

  /// Gets the total number of blocks in the current Workout of the Day (WOD).
  ///
  /// This getter returns the length of the `_blocks` list.
  ///
  /// @return The total number of blocks in the WOD.
  int get totalBlocks => _blocks.length;

  /// Gets the total number of moves in the current Workout of the Day (WOD).
  ///
  /// This getter iterates through the `_blocks` list and calculates
  /// the sum of the `totalMovesInBlock` values of the `BlockCreator`
  /// objects in the list.
  ///
  /// @return The total number of moves in the WOD.
  double get totalMoves {
    double counter = 0.0;
    for (BlockCreator block in _blocks) {
      counter = counter + block.totalMovesInBlock;
    }
    return counter;
  }

  /// Initializes the context of the current Workout of the Day (WOD)
  /// by creating the blocks in the WOD and saving them to the local database.
  ///
  /// This method simply calls the `_initContext` method.
  ///
  /// @return A `Future` that completes with the result of
  /// the initialization operation.
  Future<void>  initContext() async => await _initContext();

  /// Initializes the child context of the current Workout of the Day (WOD)
  /// by creating the moves in the blocks of the WOD.
  ///
  /// This method iterates through the `blocks` list and calls the
  /// `initMoves` method of each `BlockCreator` object in the list.
  ///
  /// @return A `Future` that completes with the result of
  /// the initialization operation.
  Future<void> initBlocks() async => await _initChildContext();

  /// Initializes the context of the current Workout of the Day (WOD)
  /// by creating the blocks in the WOD and saving them to the local database.
  ///
  /// This method creates a list of integers representing the
  /// indices of the blocks in the WOD, and then iterates through
  /// the list to create a new `BlockCreator` object for each block.
  /// The `BlockCreator` constructor takes the `context`, `index`,
  /// `blockDuration`, `mode`, and `sets` values from the
  /// `blocksGeneralInformation` map, and the `save` method is
  /// called to save the block to the database. The new block
  /// is then added to the `blocks` list.
  ///
  /// @return A `Future` that completes with the result of
  /// the initialization operation.
  Future<void> _initContext() async {
    // Create the blocks in the WOD
    int tempTotalBlocks = blocksGeneralInformation['mode']?.length ?? 1;
    List<int> indexBlock = Iterable<int>.generate(tempTotalBlocks).toList();
    for (int i in indexBlock) {
      final BlockCreator block = BlockCreator(
        context: this,
        index: i,
        blockDuration: blocksGeneralInformation['duration']![i],
        mode: blocksGeneralInformation['mode']![i],
        sets: blocksGeneralInformation['sets']![i],
      );
      await block.save();
      blocks.add(block);
    }
  }

  /// Initializes the context for each `BlockCreator` object in the `blocks` list.
  ///
  /// The function iterates over the `blocks` list and calls the `initContext()`
  /// method on each `BlockCreator` object.
  Future<void> _initChildContext() async {
    for (BlockCreator block in blocks) {
      await block.initContext();
    }
  }

  /// [Saves] the current Workout of the Day (WOD) to the local [database].
  ///
  /// This method retrieves the `WodsModel` and `Client` from the
  /// `context`, and uses them to add a new WOD to the database with
  /// the current values of the `expectedTrainingDate`, `bodyArea`,
  /// `totalBlocks`, and `isExpired` variables, as well as the `weekday`
  /// of the `expectedTrainingDate` and the `timeToTrain` of the `Client`.
  /// It then retrieves the ID of the last added WOD and assigns
  /// it to the `id` variable.
  ///
  /// @return A `Future` that completes with the result of the save operation.
  Future<void> save() async {
    final wodsModel = context.context.ref.watch(wodsModelProvider);
    final client = context.context.ref.watch(clientProvider);
    await wodsModel.addNew(expectedTrainingDate, expectedTrainingDate.weekday,
        bodyArea, totalBlocks, client.timeToTrain, isExpired);
    id = await wodsModel.getLastWODId();
  }

  /// [Updates] the total number of blocks in the current Workout
  /// of the Day (WOD) after creating moves in the local database.
  ///
  /// This method retrieves the `WodsModel` from the `context`,
  /// and uses it to call the `updateBlocksInWodAfterCreateMoves`
  /// method with the current `totalBlocks` and `id` values of the WOD.
  ///
  /// @return A `Future` that completes with the result of the update operation.
  Future<void> updateBlocksValues() async {
    final wodsModel = context.context.ref.watch(wodsModelProvider);
    await wodsModel.updateBlocksInWodAfterCreateMoves(totalBlocks, id);
  }

  /// Returns a string representation of the current Workout of the Day (WOD).
  ///
  /// This method returns a string containing the values of
  /// the `id`, `index`, `totalBlocks`, `totalMoves`, `bodyArea`,
  /// `expectedTrainingDate`, and `blocks` fields and variables,
  /// in the format 'WOD(id=ID, index=INDEX, totalBlocks=TOTAL_BLOCKS,
  /// totalMoves=TOTAL_MOVES, bodyArea=BODY_AREA,
  /// expectedTrainingDate=EXPECTED_TRAINING_DATE, blocks=BLOCKS)'.
  ///
  /// @return The string representation of the WOD.
  @override
  String toString() {
    return 'WOD(id=$id, index=$index, totalBlocks=$totalBlocks, totalMoves=$totalMoves ,bodyArea=$bodyArea, expectedTrainingDate=$expectedTrainingDate , blocks = $blocks)';
  }
}
