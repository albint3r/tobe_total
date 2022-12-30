import '../../../cliente/model/cliente_model_provider.dart';
import '../../../my_movements/model/my_movements_model.dart';
import '../../block_creator/block_creator.dart';
import '../../movement_creator/movement_creator.dart';
import 'dart:math';

abstract class Modes {
  Modes({
    required BlockCreator context,
  }) : _context = context;

  final BlockCreator _context;

  BlockCreator get currentBlock => _context;

  int get clientLevel =>
      currentBlock.context.context.context.ref.watch(clientProvider).level;

  Future<Map> get clientEquipment async =>
      currentBlock.context.context.context.ref
          .watch(clientProvider)
          .getEquipment();

  Future<void> create() async {
    // This Method Create the Block Mode Selected.
    //
    // Because is an extension of Blocks, this class have heavy relationship
    // So, this select all the move that would have the current block.
    Map<String, Object?> movementOption;
    // Iterate in all over the moves inside the Block.
    for (int i in currentBlock.listIndexMoves) {
      //1 - First Check if We have learning Moves.
      // If the list is full this will mean that We have move to learn.
      if (!await currentBlock.learningMovesIsFull()) {
        //2- Check if the Current Block is fill
        if (currentBlock.isFirstMoveToAdd) {
          // 4- Get Some Movements options
          // Iterate until the block have their first Move.
          while (currentBlock.isFirstMoveToAdd) {
            movementOption = await getLearningMove();
            MovementCreator movement = MovementCreator(
              context: currentBlock,
              index: i,
              data: movementOption,
            );
            // if the ID already exist in the Database it will skip
            // so the blocks list wont have the first Move inside.
            if (await notExistIdInMyMovements(movement.id)) {
              currentBlock.setMovement(movement);
            }
          }
        } else {
          bool finisProcess = false;
          // Until the process is not finish the method
          // would be iterated to get a movement
          int counter = 0;
          while (!finisProcess) {
            movementOption = await getLearningMoveNotCollidePrev();
            MovementCreator movement = MovementCreator(
              context: currentBlock,
              index: i,
              data: movementOption,
            );
            // if the ID already exist in the Database it will skip
            // so the blocks list wont have the first Move inside.
            print('counter -> [$counter]');
            if (await notExistIdInMyMovements(movement.id)) {
              currentBlock.setMovement(movement);
              finisProcess = !finisProcess;
            }
          }
        }
      }
    }
    print(
        '***WOD(WOD_ID=${currentBlock.context.index}, blocksInWod= ${currentBlock.context.totalBlocks})*******Block(index=${currentBlock.index}, totalMoves=${currentBlock.totalMovesInBlock}, blockDuration=${currentBlock.blockDuration}, mode=${currentBlock.mode} , sets = ${currentBlock.sets})****************');
    print(currentBlock.movements);
    print('************************************************');
  }

  void restSpecification();

  Future<Map<String, Object?>> getLearningMove() async {
    // Create and Call a query to get all the possible movements
    // for a new learning movement. In this case because is the first
    // we don't need to verify if not collide the movement pattern
    String selectedQueryBodyArea = queryBodyArea();
    String selectedQueryDifficulty = queryDifficulty();
    String selectedQueryEquipment = await queryEquipment();
    final myMovementsModel =
        currentBlock.context.context.context.ref.watch(myMovementsProvider);
    List<Map<String, Object?>> movementOption =
        await myMovementsModel.getAllPossibleMovements(
      selectedQueryBodyArea,
      selectedQueryDifficulty,
      selectedQueryEquipment,
    );
    Random random = Random();
    int randomIndex = random.nextInt(movementOption.length);
    return movementOption[randomIndex];
  }

  Future<bool> notExistIdInMyMovements(int moveId) {
    // Check if the Id already exist in MyMovements
    // Return true if the ID [not exist.]
    final myMovementsModel =
        currentBlock.context.context.context.ref.watch(myMovementsProvider);
    return myMovementsModel.notExistID(moveId);
  }

  Future<Map<String, Object?>> getLearningMoveNotCollidePrev() async {
    // Create and Call a query to get all the possible movements
    // for a new learning movement. In this case because is the first
    // we don't need to verify if not collide the movement pattern
    String selectedQueryBodyArea = queryBodyArea();
    String selectedQueryDifficulty = queryDifficulty();
    String selectedQueryEquipment = await queryEquipment();
    final myMovementsModel =
        currentBlock.context.context.context.ref.watch(myMovementsProvider);
    // Get previous movement pattern to avoid to have a collision.
    List<Map<String, Object?>> movementOption =
        await myMovementsModel.getAllPossibleMovementsNotCollidePrev(
            selectedQueryBodyArea,
            selectedQueryDifficulty,
            selectedQueryEquipment,
            getLastMovementPattern);
    Random random = Random();
    int randomIndex = random.nextInt(movementOption.length);
    return movementOption[randomIndex];
  }

  String get getLastMovementPattern {
    // Return the las movement pattern.
    MovementCreator lastMove = currentBlock.movements.last;
    return lastMove.movementPattern;
  }

  Future<String> queryEquipment() async {
    // Obtenemos el diccionario con el equipamiento del cliente
    final response = await clientEquipment;
    // Inicializamos la variable que almacenará la consulta
    String query = 'WHERE ';

    // Recorremos cada elemento del diccionario
    for (var entry in response.entries) {
      // Si el valor es igual a 1, añadimos la columna y su valor a la consulta
      if (entry.value == 1) {
        query += '${entry.key} = ${entry.value} AND ';
      }
    }

    // Eliminamos el último AND sobrante
    query = query.substring(0, query.length - 5);

    return query;
  }

  String queryBodyArea() {
    // Select a Query that would only return the movements
    // whit the same [BodyArea]
    switch (currentBlock.bodyArea) {
      case 'full_body':
        {
          return "WHERE body_area = 'full_body' OR body_area = 'core' OR body_area = 'upper' OR body_area = 'lower' OR body_area = 'monostructural'";
        }
      case 'upper':
        {
          return "WHERE body_area = 'upper' OR body_area = 'core' OR body_area = 'monostructural'";
        }
      case 'lower':
        {
          return "WHERE body_area = 'lower' OR body_area = 'core' OR body_area = 'monostructural'";
        }

      default:
        {
          return "WHERE body_area = 'full_body' OR body_area = 'core' OR body_area = 'upper' OR body_area = 'lower' OR body_area = 'monostructural'";
        }
    }
  }

  String queryDifficulty() {
    // Select a Query that would only return the movements
    // whit the same [BodyArea]
    switch (clientLevel) {
      case 0:
        {
          return "WHERE difficulty = 'beginner'";
        }
      case 1:
        {
          return "WHERE difficulty = 'beginner' OR difficulty = 'intermediate'";
        }
      case 2:
        {
          return "WHERE difficulty = 'beginner' OR difficulty = 'intermediate' OR difficulty = 'advanced'";
        }

      default:
        {
          return "WHERE difficulty = 'beginner' OR difficulty = 'intermediate' OR difficulty = 'advanced' OR difficulty = 'elit'";
        }
    }
  }
}
