import '../movement_creator/movement_creator.dart';
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
  late final List<MovementCreator> _movements = [];

  WODCreator get context => _context;
  // Add the movement to the Blocks
  void setMovement(MovementCreator movement) => _movements.add(movement);

  double get totalMovesInBlock => blockDuration / sets;
  List<int> get listIndexMoves => Iterable<int>.generate(totalMovesInBlock.round()).toList();
  // Return true if the list have movements
  bool get areMovements => _movements.isNotEmpty;

  void initContext() => _initContext();

  void _initContext() {

    print('----------GENERAL DATA---------------');
    print(context.context);
    print('---------- [${context.index}] WOD DATA-------------------');
    print(context);
    print('---------- [$index] Block DATA-----------------');
    print(this);
    print('');
    print('');
    for (int i in listIndexMoves) {
      // if(areMovements) {
      //   print('Are movements');
      // }
      MovementCreator movement = MovementCreator(
        context: this,
        index: i,
        totalMoves: totalMovesInBlock,
      );
      setMovement(movement);
    }
  }

  @override
  String toString() {
    return 'Block(index=$index, totalMoves=$totalMovesInBlock, blockDuration=$blockDuration, mode=$mode , sets = $sets, moves=$_movements)';
  }
}
