import 'package:tobe_total/src/providers/cliente/model/cliente_model_provider.dart';
import '../../wod/model/wod_model_provider.dart';
import '../block_creator/block_creator.dart';
import '../training_week_creator/training_week_creator.dart';

class WODCreator {
  WODCreator(
      {required TrainingWeek context,
      required this.index,
      required this.bodyArea,
      required this.expectedTrainingDate,
      required this.blocksGeneralInformation})
      : _context = context;

  late final TrainingWeek _context;
  late int _id;
  int index;
  String bodyArea;
  DateTime expectedTrainingDate;
  Map<String, List> blocksGeneralInformation;
  final List<BlockCreator> _blocks = [];

  /// The ID of the WOD.
  int get id => _id;

  /// Sets the ID of the WOD.
  set id(int id) => _id = id;

  /// The training week context of the WOD.
  TrainingWeek get context => _context;

  /// The list of `BlockCreator` objects in the WOD.
  List<BlockCreator> get blocks => _blocks;

  /// The total number of blocks in the WOD.
  int get totalBlocks => _blocks.length;

  /// The total number of moves in the WOD.
  double get totalMoves {
    // Return the total moves in the wod
    double counter = 0.0;
    for (BlockCreator block in _blocks) {
      counter = counter + block.totalMovesInBlock;
    }
    return counter;
  }

  /// Returns `true` if the current day is after the expected training date, `false` otherwise.
  bool get isExpired => DateTime.now().weekday > expectedTrainingDate.weekday;

  /// Initializes the context for the `BlockCreator` objects in the `blocks` list.
  void initContext() => _initContext();

  /// Initializes the context for each `BlockCreator` object in the `blocks` list.
  void initBlocks() => _initChildContext();

  /// Initializes the context for the `BlockCreator` objects in the `blocks` list.
  ///
  /// The function determines the number of blocks to create based on the `mode` field in the `blocksGeneralInformation` map.
  /// It then generates a list of integers from 0 to the number of blocks, inclusive.
  /// Finally, it iterates over the list of integers and creates a new `BlockCreator` object for each integer,
  /// passing in the necessary information from the `blocksGeneralInformation` map as arguments to the constructor.
  void _initContext() {
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
      block.save();
      print('--------Aqui estoy--------------');
      print('---------${block.id}-------------');
      print('----------------------');
      print('----------------------');
      print('----------------------');
      blocks.add(block);
    }
  }

  /// Saves a new WOD to the database.
  ///
  /// The function retrieves the `wodsModel` and `client` objects using the `context.context.ref.watch()` method,
  /// and then adds a new WOD to the database using the `addNew()` method of the `wodsModel` object.
  /// Finally, it retrieves the last inserted WOD id using the `getLastWODId()` method of the `wodsModel` object.
  Future<void> save() async {
    final wodsModel = context.context.ref.watch(wodsModelProvider);
    final client = context.context.ref.watch(clientProvider);
    await wodsModel.addNew(expectedTrainingDate, expectedTrainingDate.weekday,
        bodyArea, totalBlocks, client.timeToTrain);
    id = await wodsModel.getLastWODId();
  }

  /// Initializes the context for each `BlockCreator` object in the `blocks` list.
  ///
  /// The function iterates over the `blocks` list and calls the `initContext()` method on each `BlockCreator` object.
  void _initChildContext() {
    print('-----------------------');
    print('-------A----------------');
    print('-----------------------');
    print('-----------------------');
    print('-----------------------');
    print(blocks);
    for (BlockCreator block in blocks) {
      print('----------B-------------');
      print('--------B--------------');
      print('---------B--------------');
      print('---------B--------------');
      print('---------B--------------');
      block.initContext();
    }
  }

  @override
  String toString() {
    return 'WOD(id=$id, index=$index, totalBlocks=$totalBlocks, totalMoves=$totalMoves ,bodyArea=$bodyArea, expectedTrainingDate=$expectedTrainingDate , blocks = $blocks)';
  }
}
