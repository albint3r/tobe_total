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

  void setBlocks() {
    // Create the blocks in the WOD
    int totalBlocks = blocksGeneralInformation['mode']?.length ?? 1;
    List<int> indexBlock = Iterable<int>.generate(totalBlocks).toList();
    for (int i in indexBlock) {
      final BlockCreator block = BlockCreator(
        context: this,
        index: i,
        blockDuration: blocksGeneralInformation['duration']![i],
        mode: blocksGeneralInformation['mode']![i],
        sets: blocksGeneralInformation['sets']![i],
      );
      blocks.add(block);
    }
  }

  @override
  String toString() {
    return 'WOD(index=$index, bodyArea=$bodyArea, expectedTrainingDate=$expectedTrainingDate , blocks = $blocks';
  }
}
