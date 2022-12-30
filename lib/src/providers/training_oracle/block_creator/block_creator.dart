import '../movements_selector/abstract_modes/emom/emom_creator.dart';
import '../movements_selector/abstract_modes/modes.dart';
import '../movements_selector/abstract_modes/rounds/round_creator.dart';
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

  List<MovementCreator> get movements => _movements;

  // Add the movement to the Blocks
  void setMovement(MovementCreator movement) => _movements.add(movement);

  double get totalMovesInBlock => blockDuration / sets;

  List<int> get listIndexMoves =>
      Iterable<int>.generate(totalMovesInBlock.round()).toList();

  // Return true if the list have movements
  bool get areMovements => _movements.isNotEmpty;

  // Return [true] if the [movement] list is [full]
  bool get isFill => totalMovesInBlock == _movements.length;

  // If the List of movements is empty this will mean
  // that the next move is the first.
  bool get isFirstMoveToAdd => _movements.isEmpty;

  void initContext() => _initContext();

  Future<bool> learningMovesIsFull() => context.context.learningMovesIsFull();

  // Get the body area of the WOD
  String get bodyArea => context.bodyArea;

  // Depending of the Mode it will return their constructor.
  Modes getModeCreator() => mode == 'round'
      ? RoundsCreator(context: this)
      : EMOMCreator(context: this);

  Future<void> _initContext() async {
    print('----------GENERAL DATA---------------');
    print(context.context);
    print('---------- [${context.index}] WOD DATA-------------------');
    print(context);
    print('---------- [$index] Block DATA-----------------');
    print(this);
    print('');
    print('');
    // Select the ModeCreator to create the moves
    // This is a extension of the block Model
    Modes modeCreator = getModeCreator();
    modeCreator.create();
  }

  @override
  String toString() {
    return 'Block(index=$index, totalMoves=$totalMovesInBlock, blockDuration=$blockDuration, mode=$mode , sets = $sets, moves=$_movements)';
  }
}
