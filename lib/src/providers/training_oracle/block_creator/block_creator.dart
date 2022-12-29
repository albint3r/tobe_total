import '../wod_creator/wod_creator.dart';

class BlockCreator {
  BlockCreator({
    required WODCreator context,
    required this.index,
    required this.blockDuration,
    required this.mode,
    required this.sets,
  }) : _context = context;

  int index;
  int blockDuration;
  String mode;
  int sets;
  final WODCreator _context;

  @override
  String toString() {
    return 'Block(index=$index, blockDuration=$blockDuration, mode=$mode , sets = $sets';
  }
}
