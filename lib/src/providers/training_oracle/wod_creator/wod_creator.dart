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
  int index;
  String bodyArea;
  DateTime expectedTrainingDate;
  Map<String, List> blocksGeneralInformation;
  final List<BlockCreator> _blocks = [];

  TrainingWeek get context => _context;

  List<BlockCreator> get blocks => _blocks;

  // Is the total blocks in the WOD.
  int get totalBlocks => _blocks.length;

  double get totalMoves {
    // Return the total moves in the wod
    double counter = 0.0;
    for (BlockCreator block in _blocks) {
      counter = counter + block.totalMovesInBlock;
    }
    return counter;
  }

  // Return True if the day is already expired.
  bool get isExpired => DateTime.now().weekday > expectedTrainingDate.weekday;

  void initContext() => _initContext();

  void initBlocks() => _initChildContext();

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
      // print('--------STATUS Block-------------');
      // print(block);
      // print('');
      blocks.add(block);
    }
  }

  void _initChildContext() {
    for (BlockCreator block in blocks) {
      block.initContext();
    }
  }

  @override
  String toString() {
    return 'WOD(index=$index, totalBlocks=$totalBlocks, totalMoves=$totalMoves ,bodyArea=$bodyArea, expectedTrainingDate=$expectedTrainingDate , blocks = $blocks)';
  }
}
