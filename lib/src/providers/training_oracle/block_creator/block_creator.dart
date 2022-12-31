import '../../block/model/block_model_provider.dart';
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
  late int _id;
  int index;
  int blockDuration;
  String mode;
  int sets;
  final WODCreator _context;
  late final List<MovementCreator> _movements = [];

  int get id => _id;
  set id(int id)=> _id=id;

  WODCreator get context => _context;

  List<MovementCreator> get movements => _movements;

  // Add the movement to the Blocks
  void setMovement(MovementCreator movement) => _movements.add(movement);

  double get totalMovesInBlock => blockDuration / sets;

  List<int> get getPossibleCreateMoves =>
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

  void _initContext()  {
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
    updateBlocksInWOD();
  }


  void updateBlocksInWOD()=> context.updateBlocksValues();


  /// Saves the current block to the database.
  ///
  /// The block is added to the `blocks` table and its identifier is updated.
  Future<void> save() async {
    final blockModel = context.context.context.ref.watch(blocksModelProvider);
    await blockModel.addNew(context.id, mode, sets, blockDuration, totalMovesInBlock.toInt());
    id = await blockModel.getLastBlockId();
  }

  @override
  String toString() {
    return 'Block(index=$index, totalMoves=$totalMovesInBlock, blockDuration=$blockDuration, mode=$mode , sets = $sets, moves=$_movements)';
  }
}
